USE [ULTIPRO_SMG]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_ESCHWAB]    Script Date: 12/22/2021 10:35:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESCHWAB]
    @systemid char(12)
AS
/************************************************************
Client: Summit Medical Group     

Created By: Ellen Havdahl
Business Analyst: Fernando Gutierrez             
Create Date: 03/04/2010
ChangePoint Request Number: 27572

Purpose: 401K export for Charles Schwab
-- PRIMARY KEY CONSTRAINT = '7X1T7L0010K1'

Revision History
-----------------
Update By            Date            CP Num                Desc 
Ellen Havdahl        3/4/2010        27572                Initial  Code      
Tanya Leonce        11/14/2014        SR-2014-00065512    Updates Per Spec v2.3 - Update "Alternate Key #2"
Dave Smith            2/22/2018        SR-2018-00183882    Added benefit status field in column 29

10/25/2021 by AP:
        - Added email field and transfer indicator field.
        - Added logic to show "X" for transfer indicator.
        - Cleaned up new file field counts to accommodate for new fields.

11/08/2021 by AP:
        - Updated format to group amounts to employees for both term and active amounts.
        - Created temp table for existing driver table.

12/09/2021 by AP:
        - Updated logic for PerHrsWork.

12/22/2021 by AP:
		- Fixed status and status date showing incorrectly.

SELECT * FROM U_Dsi_Configuration WHERE FormatCode = 'ESCHWAB'
SELECT * FROM U_Dsi_SqlClauses WHERE FormatCode = 'ESCHWAB'
SELECT * FROM U_Dsi_parameters WHERE FormatCode = 'ESCHWAB'
SELECT * FROM AscExp WHERE ExpFormatCode = 'ESCHWAB'
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESCHWAB' ORDER BY RunID DESC;



EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESCHWAB', @AllObjects = 'Y', @IsWeb = 'N'

EXEC dbo.dsi_sp_testswitchbox_v2 'ESCHWAB', 'ESCHWAB'
EXEC dbo.dsi_sp_testswitchbox_v2 'ESCHWAB', 'TEST'
************************************************************/
BEGIN


    /**********************************
    DROP TABLE IF IT ALREADY EXISTS
    ***********************************/

    IF object_id ('U_ESCHWAB_EEList_401k') IS NOT NULL
        DROP TABLE dbo.U_ESCHWAB_EEList_401k
    IF object_id ('U_dsi_ESCHWAB_drvtbl_temp') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_drvtbl_temp
    IF object_id ('U_dsi_ESCHWAB_drvtrl') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_drvtrl
    IF object_id ('U_dsi_ESCHWAB_curdedamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_curdedamts
    IF object_id ('U_dsi_ESCHWAB_YTDdedamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_YTDdedamts
    IF object_id ('U_dsi_ESCHWAB_curearnamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_curearnamts
    IF object_id ('U_dsi_ESCHWAB_YTDearnamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_YTDearnamts


    /*********************************************
    Declare date variables to use for filtering
    **********************************************/
    DECLARE @startdate datetime,
            @enddate datetime,
            @startpc char(9),
            @endpc char(9)


    /**********************************
      RUN EXPORT
    ***********************************/
    SELECT @startdate = convert(datetime,SUBSTRING(StartPercontrol,1,8)),
           @enddate = convert(datetime,SUBSTRING(EndPerControl,1,8)),
           @startpc = startpercontrol,
           @endpc = endpercontrol
    FROM dbo.U_dsi_Parameters
    WHERE formatcode = 'ESCHWAB'



    /****************************************
     GET EMPLOYEES FOR DETAIL RECORD
    ****************************************/

    select distinct xeeid, xcoid 
    into dbo.U_ESCHWAB_EEList_401k
    from dbo.U_ESCHWAB_EEList with (nolock) 
    join dbo.empcomp with (nolock) on eeceeid = xeeid and eeccoid = xcoid
    where eecemplstatus <> 'T' or 
    (
        eecemplstatus = 'T' and 
        ( 
            year(eecdateoftermination) = year(@startdate) 
            or 
            year(eecdateoftermination) = year(@enddate)
            -- HEG - 20110310
            or
            year(eecdateoftermination) = year(@startdate) - 1 -- prev yr
            or 
            year(eecdateoftermination) = year(@enddate) - 1 -- prev yr
        )
    )

    
    /***************************************************
    CREATE TABLE WITH DATA ELEMENTS - 401k Detail record  
    ****************************************************/

    SELECT            
        drveeid = eeceeid,
        drvcoid = eeccoid,
        drvssn = eepssn,
        drvlastname = eepnamelast,
        drvfirstname = eepnamefirst,
        drvmiddlename = left(eepnamemiddle,1),
        drv401KREGamt = convert(money,0), 
        drv401KREG = '00000000000',
        drvMATCHamt = convert(money,0), 
        drvMATCH = '00000000000',
        drvPROFITSHAREamt = convert(money,0),
        drvPROFITSHARE = '00000000000',
        drv401KROTHamt = convert(money,0), 
        drv401KROTH = '00000000000',
        drvSAFEHARBORamt = convert(money,0),
        drvSAFEHARBOR = '00000000000',
        drvloanamt = convert(money,0),
        drvloan = '00000000000',
        drvPerTotCompamt = convert(money,0),
        drvPerTotComp = '00000000000',
        drvPerHrsWorkamt = convert(int,0),
        drvPerHrsWork = '0000',
        drvYTD401Kamt = convert(money,0),
        drvYTD401K = '00000000000',
        drvYTDMATCHamt = convert(money,0), 
        drvYTDMATCH = '00000000000',
        drvYTDPSamt = convert(money,0),
        drvYTDPS = '00000000000',
        drvYTDROTHamt = convert(money,0), 
        drvYTDROTH = '00000000000',
        drvYTDSHamt = convert(money,0),
        drvYTDSH = '00000000000',
        drvYTDTotCompamt = convert(money,0),
        drvYTDTotComp = '00000000000',
        drvYTDHrsWorkamt = convert(int,0),
        drvYTDHrsWork = '0000',
        drvfreq = eecpayperiod,
        drvaddress1 = eepaddressline1,
        drvaddress2 = eepaddressline2,
        drvcity = eepaddresscity,         
        drvstate = eepaddressstate,      
        drvzipcode = case when len(eepaddresszipcode) = 5 then eepaddresszipcode
                    else left(eepaddresszipcode,5) + '-' + substring(eepaddresszipcode,6,4) end,
        drvcountry = eepaddresscountry,
        drvdob = replace(convert(char(10),eepdateofbirth,101),'/',''),
        drvhiredate = replace(convert(char(10),eecdateoforiginalhire,101),'/',''),
        drvplandate = convert(char(8),NULL),
        drvtermdate = replace(convert(char(10),eecdateoftermination,101),'/',''),
        drvrehiredt = case when eecdateoflasthire <> eecdateoforiginalhire then replace(convert(char(10),eecdateoflasthire,101),'/','') end,
        drvstatus = case when eepdatedeceased is not NULL then 'X'
                       when eectermreason = '202' then 'R'
                       else eecemplstatus end,
        drvrptdivision = eecorglvl4,
        drvaltkey1 = eepgender,
        drvaltkey2 = EecOrgLvl2,        -- 11/14/2014, TL - Replaced cmpcompanycode
        drvworkphone = case when cmpphonenumber is not NULL then left(cmpphonenumber,3) + '-' + substring(cmpphonenumber,4,3) + '-' + substring(cmpphonenumber,7,4) 
                                                          else ' ' end  , 
        --SR-2018-00183882
        drvBenefitStatusReason =    CASE 
                                        WHEN PNPSE.EedBenStatus IS NOT NULL AND PNPSP.EedBenStatus IS NULL THEN PNPSE.EedBenStatus
                                        WHEN PNPSE.EedBenStatus = 'T' AND PNPSP.EedBenStatus = 'A' THEN PNPSP.EedBenStatus
                                        ELSE ISNULL(PNPSE.EedBenStatus,PNPSP.EedBenStatus)
        END,
        drvEmailAddress = EepAddressEmail,
        drvTransferIndicator = '' --CASE WHEN EecEmplStatus = 'T' THEN 'X' ELSE '' END
    into dbo.U_dsi_ESCHWAB_drvtbl_temp
    from dbo.U_ESCHWAB_EEList_401k
    join dbo.empcomp with (nolock) on eeceeid = xeeid and eeccoid = xcoid
    join dbo.emppers with (nolock) on eeceeid = eepeeid
    join dbo.company with (nolock) on cmpcoid = eeccoid
    --SR-2018-00183882 - added supporting tables to pull specific deduction details for PNPSE and PNPSP
    LEFT OUTER JOIN dbo.EmpDed AS PNPSE WITH (NOLOCK) on PNPSE.EedEEID = xeeid AND PNPSE.EedCoID = xcoid AND PNPSE.EedDedCode = 'PNPSE'
    LEFT OUTER join dbo.EmpDed AS PNPSP WITH (NOLOCK) on PNPSP.EedEEID = xeeid AND PNPSP.EedCoID = xcoid AND PNPSP.EedDedCode = 'PNPSP'

    /* update current ded amounts */
    SELECT
        pdheeid, 
        pdhcoid,
        case when pdhdedcode in ('401DE','401DP') then 'source1' 
           when pdhdedcode in ('401ME','401MP') then 'source3' 
           when pdhdedcode in ('PNPSE','PNPSP') then 'source4' 
           when pdhdedcode in ('401RE','401RP') then 'source5' 
           when pdhdedcode in ('PNSHE','PNSHP') then 'source6' 
           when pdhdedcode in ('401KL') then 'loan1' end as dedcode,
        sum(case when pdhdedcode in ('401dp','401rp') then 0 else pdheecuramt end) as eecuramt,
        sum(case when pdhdedcode in ('401de','401re') then 0 else pdhercuramt end) as ercuramt
    into dbo.U_dsi_ESCHWAB_curdedamts
    from dbo.pdedhist with (nolock)
    join dbo.U_dsi_ESCHWAB_drvtbl_temp with (nolock) on drveeid = pdheeid and drvcoid = pdhcoid
    where pdhdedcode in ('401DE','401DP','401ME','401MP','PNPSE','PNPSP','401RE','401RP','PNSHE','PNSHP','401KL')
    and pdhpercontrol between @startpc and @endpc
    group by pdheeid, pdhcoid,
      case when pdhdedcode in ('401DE','401DP') then 'source1' 
           when pdhdedcode in ('401ME','401MP') then 'source3' 
           when pdhdedcode in ('PNPSE','PNPSP') then 'source4' 
           when pdhdedcode in ('401RE','401RP') then 'source5' 
           when pdhdedcode in ('PNSHE','PNSHP') then 'source6' 
           when pdhdedcode in ('401KL') then 'loan1' end

    ---- TRANSFER COMPANY ANALYSIS ----
    IF OBJECT_ID('U_ESCHWAB_Transfer','U') IS NOT NULL
    DROP TABLE dbo.U_ESCHWAB_Transfer;

    SELECT *, ROW_NUMBER() OVER(PARTITION by drveeid order by drvtermdate) as rn
    INTO dbo.U_ESCHWAB_Transfer
    FROM dbo.U_dsi_ESCHWAB_drvtbl_temp

    IF OBJECT_ID('U_ESCHWAB_Transfer_Final','U') IS NOT NULL
    DROP TABLE dbo.U_ESCHWAB_Transfer_Final;

    SELECT *, drveeid as teeid, drvcoid as tcoid, 'X' as tid
    INTO dbo.U_ESCHWAB_Transfer_Final
    FROM dbo.U_ESCHWAB_Transfer 
    WHERE rn > 1 
    AND drvStatus = 'T'
    -----------------------------------

    UPDATE dbo.U_dsi_ESCHWAB_drvtbl_temp
    SET drvTransferIndicator = tid
    FROM dbo.U_dsi_ESCHWAB_drvtbl_temp a JOIN dbo.U_ESCHWAB_Transfer_Final b
    ON a.drveeid = b.teeid AND a.drvcoid = b.tcoid

    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drv401KREGamt = eecuramt+ercuramt,
        drv401KREG = dbo.dsi_fnPadZero((eecuramt+ercuramt)*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source1'


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvMATCHamt = ercuramt,
        drvMATCH = dbo.dsi_fnPadZero(ercuramt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source3'


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvPROFITSHAREamt = ercuramt,
        drvPROFITSHARE = dbo.dsi_fnPadZero(ercuramt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source4'


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drv401KROTHamt = eecuramt+ercuramt,
        drv401KROTH = dbo.dsi_fnPadZero((eecuramt+ercuramt)*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source5'


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvSAFEHARBORamt = ercuramt,
        drvSAFEHARBOR = dbo.dsi_fnPadZero(ercuramt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source6'


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvLoanamt = eecuramt,
        drvLoan = dbo.dsi_fnPadZero(eecuramt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'loan1'


    /* update current earn amounts */
    select peheeid, pehcoid, sum(case when erninclindefcomphrs = 'Y' then pehcurhrs else 0 end) as eecurhrs,
           sum(case when erninclindefcomp = 'Y' then pehcuramt else 0 end) as eecuramt   
    into dbo.U_dsi_ESCHWAB_curearnamts
    from dbo.pearhist with (nolock)
    join dbo.U_dsi_ESCHWAB_drvtbl_temp with (nolock) on drveeid = peheeid and drvcoid = pehcoid 
    join dbo.earncode on ernearncode = pehearncode
    where pehpercontrol between @startpc and @endpc
    group by peheeid, pehcoid

    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvPerTotCompamt = eecuramt,
        drvPerTotComp = dbo.dsi_fnPadZero(eecuramt*100,11,0),
        drvPerHrsWorkamt = eecurhrs,
        drvPerHrsWork = dbo.dsi_fnPadZero(eecurhrs,4,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_curearnamts  with (nolock) on peheeid = drveeid and pehcoid = drvcoid 


    /* update YTD ded amounts */
    SELECT
        eedeeid, 
        eedcoid,
        case when eeddedcode in ('401DE','401DP') then 'source1' 
           when eeddedcode in ('401ME','401MP') then 'source3' 
           when eeddedcode in ('PNPSE','PNPSP') then 'source4' 
           when eeddedcode in ('401RE','401RP') then 'source5' 
           when eeddedcode in ('PNSHE','PNSHP') then 'source6' end as dedcode, 
        sum(case when eeddedcode in ('401dp','401rp') then 0 else eedeeYTDamt end) as eeYTDamt,
        sum(case when eeddedcode in ('401de','401re') then 0 else eederYTDamt end) as erYTDamt
    into dbo.U_dsi_ESCHWAB_YTDdedamts
    from dbo.empded with (nolock)
    join dbo.U_dsi_ESCHWAB_drvtbl_temp with (nolock) on drveeid = eedeeid and drvcoid = eedcoid
    where eeddedcode in ('401DE','401DP','401ME','401MP','PNPSE','PNPSP','401RE','401RP','PNSHE','PNSHP')
    group by eedeeid, eedcoid,
      case when eeddedcode in ('401DE','401DP') then 'source1' 
           when eeddedcode in ('401ME','401MP') then 'source3' 
           when eeddedcode in ('PNPSE','PNPSP') then 'source4' 
           when eeddedcode in ('401RE','401RP') then 'source5' 
           when eeddedcode in ('PNSHE','PNSHP') then 'source6' end 
      

    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvYTD401Kamt = eeYTDamt+erYTDamt,
        drvYTD401K = dbo.dsi_fnPadZero((eeYTDamt+erYTDamt)*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source1'


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvYTDMATCHamt = erYTDamt,
        drvYTDMATCH = dbo.dsi_fnPadZero(erYTDamt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source3'


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvYTDPSamt = erYTDamt,
        drvYTDPS = dbo.dsi_fnPadZero(erYTDamt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source4'


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvYTDROTHamt = eeYTDamt+erYTDamt,
        drvYTDROTH = dbo.dsi_fnPadZero((eeYTDamt+erYTDamt)*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source5'


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvYTDSHamt = erYTDamt,
        drvYTDSH = dbo.dsi_fnPadZero(erYTDamt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source6'


    /* update YTD earn amounts */
    select eeeeeid, eeecoid, sum(case when erninclindefcomphrs = 'Y' then eeeYTDhrs else 0 end) as eeYTDhrs,
           sum(case when erninclindefcomp = 'Y' then eeeYTDamt else 0 end) as eeYTDamt
    into dbo.U_dsi_ESCHWAB_YTDearnamts
    from dbo.empearn with (nolock)
    join dbo.U_dsi_ESCHWAB_drvtbl_temp with (nolock) on drveeid = eeeeeid and drvcoid = eeecoid 
    join dbo.earncode on ernearncode = eeeearncode
    group by eeeeeid, eeecoid


    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvYTDTotCompamt = eeYTDamt,
        drvYTDTotComp = dbo.dsi_fnPadZero(eeYTDamt*100,11,0),
        drvYTDHrsWorkamt = eeYTDhrs,
        drvYTDHrsWork = dbo.dsi_fnPadZero(eeYTDhrs,4,0)
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join dbo.U_dsi_ESCHWAB_YTDearnamts  with (nolock) on eeeeeid = drveeid and eeecoid = drvcoid 

    /* update Plan Entry Date */
    select eedeeid, eedcoid, eedeeeligdate
    into #PNPSE
    from dbo.empded
    where eeddedcode = 'PNPSE'
    and eedbenstopdate is NULL
      
    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvplandate = replace(convert(char(10),eedeeeligdate,101),'/','')
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join #PNPSE on eedeeid = drveeid and eedcoid = drvcoid
     
    select eedeeid, eedcoid, eedeeeligdate
    into #PNPSP
    from dbo.empded
    where eeddedcode = 'PNPSP'
    and eedbenstopdate is NULL
      
    update dbo.U_dsi_ESCHWAB_drvtbl_temp
    set drvplandate = replace(convert(char(10),eedeeeligdate,101),'/','')
    from dbo.U_dsi_ESCHWAB_drvtbl_temp
    join #PNPSP on eedeeid = drveeid and eedcoid = drvcoid
    where drvplandate is NULL


    ---- FINAL OUTPUT TABLE WITH AGGREGATES FOR EMPLOYEE ----

    IF OBJECT_ID('U_dsi_ESCHWAB_drvtbl','U') IS NOT NULL
    DROP TABLE dbo.U_dsi_ESCHWAB_drvtbl;

    
    SELECT 
        drveeid,
        drvssn,
        drvlastname,
        drvfirstname,
        drvmiddlename,
        sum(drv401KREGamt) as drv401KREGamt,
        RIGHT('00000000000' + cast(sum(cast(drv401KREG as int)) as varchar), 11) as drv401KREG,
        sum(drvMATCHamt) as drvMATCHamt,
        RIGHT('00000000000' + cast(sum(cast(drvMATCH as int)) as varchar), 11) as drvMATCH,
        sum(drvPROFITSHAREamt) as drvPROFITSHAREamt,
        RIGHT('00000000000' + cast(sum(cast(drvPROFITSHARE as int)) as varchar), 11) as drvPROFITSHARE,
        sum(drv401KROTHamt) as drv401KROTHamt,
        RIGHT('00000000000' + cast(sum(cast(drv401KROTH as int)) as varchar), 11) as drv401KROTH,
        sum(drvSAFEHARBORamt) as drvSAFEHARBORamt,
        RIGHT('00000000000' + cast(sum(cast(drvSAFEHARBOR as int)) as varchar), 11) as drvSAFEHARBOR,
        sum(drvloanamt) as drvloanamt,
        RIGHT('00000000000' + cast(sum(cast(drvloan as int)) as varchar), 11) as drvloan,
        sum(drvPerTotCompamt) as drvPerTotCompamt,
        RIGHT('00000000000' + cast(sum(cast(drvPerTotComp as int)) as varchar), 11) as drvPerTotComp,
        sum(drvPerHrsWorkamt) as drvPerHrsWorkamt,
        RIGHT('0000' + cast(sum(cast(drvPerHrsWork as int)) as varchar), 4) as drvPerHrsWork,
        --sum(drvPerHrsWorkamt) as drvPerHrsWorkamt,
        --RIGHT('00000000000' + cast(sum(cast(drvPerHrsWork as int)) as varchar), 11) as drvPerHrsWork,
        sum(drvYTD401Kamt) as drvYTD401Kamt,
        RIGHT('00000000000' + cast(sum(cast(drvYTD401K as int)) as varchar), 11) as drvYTD401K,
        sum(drvYTDMATCHamt) as drvYTDMATCHamt,
        RIGHT('00000000000' + cast(sum(cast(drvYTDMATCH as int)) as varchar), 11) AS drvYTDMATCH,
        sum(drvYTDPSamt) as drvYTDPSamt,
        RIGHT('00000000000' + cast(sum(cast(drvYTDPS as int)) as varchar), 11) as drvYTDPS,
        sum(drvYTDROTHamt) as drvYTDROTHamt,
        RIGHT('00000000000' + cast(sum(cast(drvYTDROTH as int)) as varchar), 11) as drvYTDROTH,
        sum(drvYTDSHamt) as drvYTDSHamt,
        RIGHT('00000000000' + cast(sum(cast(drvYTDSH as int)) as varchar), 11) as drvYTDSH,
        sum(drvYTDTotCompamt) as drvYTDTotCompamt,
        RIGHT('00000000000' + cast(sum(cast(drvYTDTotComp as int)) as varchar), 11) as drvYTDTotComp,
        sum(drvYTDHrsWorkamt) as drvYTDHrsWorkamt,
        cast(sum(cast(drvYTDHrsWork as int)) as varchar) as drvYTDHrsWork,
        max(drvfreq) as drvfreq,
        max(drvaddress1) as drvaddress1,
        max(drvaddress2) as drvaddress2,
        max(drvcity) as drvcity,
        max(drvstate) as drvstate,
        max(drvzipcode) as drvzipcode,
        max(drvcountry) as drvcountry,
        max(drvdob) as drvdob,
        max(drvhiredate) as drvhiredate,
        max(drvplandate) as drvplandate,
        max(drvtermdate) as drvtermdate,
        max(drvrehiredt) as drvrehiredt,
        max(drvstatus) as drvstatus,
        max(drvrptdivision) as drvrptdivision,
        max(drvaltkey1) as drvaltkey1,
        max(drvaltkey2) as drvaltkey2,
        max(drvworkphone) as drvworkphone,
        max(drvBenefitStatusReason) as drvBenefitStatusReason,
        max(drvEmailAddress) as drvEmailAddress,
        '' as drvTransferIndicator
        INTO dbo.U_dsi_ESCHWAB_drvtbl
        FROM U_dsi_ESCHWAB_drvtbl_temp
     --   WHERE drveeid = '7X0C780000K0'
        GROUP BY drveeid,
        drvssn,
        drvlastname,
        drvfirstname,
        drvmiddlename

-----------------------------------------------------------------


    /*************************************************************
    Build Trailer record
    *************************************************************/
        
    SELECT
        drvpedate = replace(Convert(char(10),(select max(pgpperiodenddate) from pgpayper where pgpperiodcontrol between @startpc and @endpc),101),'/',''),
        drvsource1tot = dbo.dsi_fnPadZero((select sum(drv401KREGamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl_temp),11,0),
        drvsource3tot = dbo.dsi_fnPadZero((select sum(drvMATCHamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl_temp),11,0),
        drvsource4tot = dbo.dsi_fnPadZero((select sum(drvPROFITSHAREamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl_temp),11,0),
        drvsource5tot = dbo.dsi_fnPadZero((select sum(drv401KROTHamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl_temp),11,0),
        drvsource6tot = dbo.dsi_fnPadZero((select sum(drvSAFEHARBORamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl_temp),11,0),
        drvloan1tot = dbo.dsi_fnPadZero((select sum(drvLoanamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl_temp),11,0)
    into dbo.U_dsi_ESCHWAB_drvtrl



END