CREATE PROCEDURE [dbo].[dsi_BDM_sp_PopulateDeductionsTable]  
@FormatCode VARCHAR(10)  
  
AS  
  
/************************************************************  
  
dsi_BDM_sp_PopulateDeductionsTable  
  
Created By: John Transier & Diane Hendrix  
Create Date: 07/06/2011  
  
Purpose: Populates employee and/or dependent deductions based on the parameters below.  
  
NOTE TO SUPPORT: this stored procedure is one of a standard set of DSI procedures. Please do not make any changes  
to this procedure without going through the Data Services team. Any changes made to this procedure will be wiped out  
if/when the standard DSI code is reinstalled on this database.  
  
Revision History  
----------------  
Version   Update By         Date          Descr  
1.08      John Transier     2011/08/25    Fixed bug in calculation of EedBenOptionDate  
  
1.09      John Transier     2011/09/01    1> Added Cobra functionality  
                                          2> Added relationship and birthdate fields to dbo.U_dsi_BDM_DepDeductions  
                                            
1.10      John Transier     2011/09/01    1> Added benefit option (DbnBenOption) to dbo.U_dsi_BDM_DepDeductions  
                                          2> Added GetChangeReason parm to get the latest change reason from dbo.EmpHDed  
                                          3> Added TermsOnly parm to return only terms  
                                            
1.11      John Transier     2011/09/20    1> Added AllowMultiDedType parm to allow different deductions of the same type  
                                          2> Added UseDedStopDate parm to tell the module to process deductions based on  
                                             EedStartDate/EedStopDate rather than EedBenStartDate/EedBenStopDate  
                                          3> Added InvalidateBadDeps to invalidate dependent deductions with data issues  
                                          4> Added programmer-defined fields:  
                                             EedUSGField1, EedUSGField2, EedUSGDate1, EedUSGDate2  
                                             DbnUSGField1, DbnUSGField2, DbnUSGDate1, DbnUSGDate2  
                                          5> Corrected bug where audit table was not being cleared  
                                          6> Made changes to EEList processing to improve performance  
                                            
1.12      John T/Diane H    2011/10/03    1> Added indices, changed joins and put row inserts into a separate SP to  
                                             improve performance on large clients.  
                                               
1.13      John Transier     2011/11/04    1> Added new code to set the DbnCOID and DbnBenOption  
                                          2> Added UseCobraCoveredDeds parm to control whether Cobra-covered deductions  
                                             are used by the module  
                                          3> Corrected bug in how totals were being printed  
                                          4> Added AddToPreviousRun to preserve the previous run rather than wiping it out  
                                          5> Added RunID to differentiate between runs for the same formatcode  
                                          6> Added BuildConsolidatedTable to create a single table of just the valid deductions  
                                             for both employees and dependents.  
                                          7> Added CobraPQBType parm. Tells the BDM to calculate Cobra PQBs in different ways.  
                                          8> Added CountDependents parm. Tells the BDM to count dependents. (This used to be the default,  
                                             for performance reasons it must now be set.)  
                                               
1.14      John Transier     2011/11/11    1> Added DedTypes and DedTypesDep parms  
  
1.15      John Transier     2011/11/28    1> Added SP dsi_BDM_sp_ProcessNewEnrollees to process new enrollees  
  
1.16      John Transier     2011/12/28    1> Added ExcludeDedCodes parm to exclude specific dedcodes  
                                          2> Added CobraIncludeEmps parm to validate EEs where only dependent is on Cobra  
                                          3> Added field BdmDedRowStatus to consolidated table  
                                          4> Stops will now be included if 1> the export is looking for audit date, 2> the audit date  
                                             for the stop was in the past, 3> the stop date is within the date range, 4> future stop dates  
                                             are excluded.  
                                               
1.17   Diane Hendrix  2012/01/23   1> changed the views for handling Waives not to adjust columns if status = 'C'  
                                          2> Added UPDDEDTYPE and UPDDEDCODETYPE  
                                          3> Remove override for Calcbenoptiondate when OE run  
                                          4> Modified to only use maximum emphded record if multiple recs for same day  
                                            
1.18   Diane Hendrix  2012/02/21   1> Correct Issue from 1.17 when using Manual Deductions  
  
1.19   N Wetherbee       2012/06/12   1> Correct issue with InvalidateBadDeps.  Deps were being invalidated when emp coverage was active.  
                                          2> Added OERemoveTermEmps parm to include terms in OE sessions when set to 'N' (Set to exclude by Default).  
                                          3> Added Dependent counts to consolidated table for EMP records (dsi_BDM_sp_BuildConsolidatedTable SP)  
                                            
1.20   N Wetherbee       2012/09/14   1> Correct issue with Cobra Runs not populating deduction tables with codes where DedIsCobraCovered = 'Y'  
                                             by default.  Code was assuming that deduction codes were be written to dbo.U_dsi_BDM_DeductionCodes before  
                                             the step that removes deductions which are not cobra covered.  
                                          2> Diane Hendrix added two new parameters: InvalidTermReasonsEmp and InvalidTermReasonsDep.  
                                          3> Added 3 new error checks for Dependents in: dsi_BDM_sp_ErrorCheck.  
                                          4> Replaced references to dbo.vw_auditdata with new dsi view: dsi_vw_AuditData.  
                                            
1.21   N Wetherbee       2014/03/17    1> Correct issue with dependents dropping from OE runs with error/notes of: EE is termed; OE terms are set to drop  
                                          2> Add @UseCobraCoveredDeds Param value of "X" to return the intersection of specified dedcodes/type and IsCobraCovered indicator:    
                                             X --> If DedCodes/Types ARE specified AND the @IsCobraCovered param is Y  
                                                   THEN populate BDM Dedcode table with specified DedCodes/Types where DedIsCobraCovered = 'Y'.   
                                          3> Fix @UseCobraCoveredDeds Param logic such that: If no Dedcodes and/or types specified are specified AND @UseCobraCoveredDeds  
                                             is set to "N" THEN return all deductions where DedIsCobraCovered = N  
                                          4> Cobra SP: Add logic for IF CobraType in (2,3) (uses EmpHDed for reasons) THEN always add CHGRP to the   
                                             cobra reasons table. IF CobraType = 3 THEN Only Validate records with CHGRP reason if the employee's DedGroup   
                                             value is NOT linked to any plans of type: MED, DENT, VIS, FSA.   
       5> Replaced references to dsi_vw_auditdata with standard audit view: dbo.vw_AuditData since it now   
                                             has AudProcessedDateTime and AudEffectiveDate fields.  
                                          6> New Enrollee SP: Changed disallow so that employees whom had at least one active cobra-elig deduction in   
                                             the past are NOT included as New Enrollees. New Enrollee Type 2 only. Issue identified by Vinny Kelly.  
                                          7> Invalidate Dependent records if they were marked as valid because they were recently stopped (via audit)  
                                             but the employee's deduction has long since been stopped (not in recent audit snapshot).  
                                          8> Cobra SP: Rearrange (order in SP) update statement that validates employee if they have a valid dependent (Reported by Vinny Kelly)   
                                          9> The "TableType" param of EMP was still resulting in dependent deductions being included in the consolidated table  
                                             if they were generated during a previous run of the same formatcode with dependents.  Deleting prior runs before generating  
                                             new records was being done based on the TableType value being EMP or DEP.  We set both Employee and Dependent  
                                             records in dbo.u_dsi_BDM_EmpDeductions and dbo.u_dsi_BDM_DepDeductions to be deleted before a new BDM run no matter what the  
                                             TableType param is set to. Issue identified by Megan Grieves.  
                                          10>Update joins used in queries on Audit view to reduce latency for large clients.   
1.22   S Beever/  
          N Wetherbee       2014/08/27    1> Add param to apply alternative PQB assignment logic: @CobraPQBMulti    
            
1.23   S Beever/  
    N Wetherbee  2015/01/30   1> Updated BDM assessment of ASP vs. .NET licences for Clients registered as .Net but wanted to load records to dbo.LodEded for benefits.  
            2> When checking for coverage stops in Audit use @EEStopDateField to ensure that field that was specified is checked against audit   
           (EedBenStopDate vs. EedStopDate)  
            3> For inserts into dbo.U_dsi_BDM_Audit, only consider AudEffectiveDate when within date range AND where AudEffectiveDate > AudProcessedDateTime  
1.24   S Beever/  
    N Wetherbee  2015/08/18   1> Set audit query in main SP to ignore waives.  (Reported by Vinny Kelly)  
                                    2> Modification to automatically handle stops for Deduction only codes using eedStopDate when DedIsBenefit <> 'Y'  
            3> Updated syntax for CTE statements to terminate previous statement with a semicolon  
                                          4> Added version history table (dbo.U_dsi_BDM_VersionHistory) to track BDM versions applied ongoing.  Included functionality that would deny   
                                             a deployment if a greater version had been previously applied.                                                                    
1.25   S Beever/  
    N Wetherbee  2016/05/02   1> As a result of 2016-R1 updates to dbo.EmpDedFull and dbo.DepBPlanFull views, we experienced latency when running the table-valued functions  
                                       dbo.fn_BDM_EmpDed, dbo.fn_BDM_EmpDedNetOE, dbo.fn_BDM_DepBPlan and dbo.fn_BDM_DepBPlanNetOE.  These functions were updated to replace multiple  
                                       references to the dbo.EmpDedFull and dbo.DepBPlanFull views with dbo.EmpDedTV and dbo.DepBPlanTV respectively. The legacy views were updated as well.  
             
1.26      S Beever/  
          N Wetherbee       2016/08/01    1> Added EdhRowChangeRsn into dbo.U_dsi_BDM_EmpHDed_max.    
                        The most recent Change Reason was not being properly identified due to the parition by EdhEffDate in EdhRowNum  
            2> Updated display of @Version to reference dbo.U_dsi_BDM_VersionHistory  
          
1.27      S Beever/  
          N Wetherbee       2016/09/19    1> ConsolidatedTable SP: BDM will now calculate number of dependents on dependent records within consolidated table  
                                    2> ConsolidatedTable SP: Added ability to add custom (TC Defined) fields to the consolidated table   
            3> Updated string variables that contain DedCode/DedType lists to VARCHAR (8000), to avoid previous field length limitations.  
                                          4> COBRA SP: Corrected PQB rules for domestic partners & domestic partners children, to ensure these relationships are accurately   
               reflected as PQB, if applicable.              
                                          5> New Enrollee SP: Correction to NewEnrolleeDeps = '2' logic. The RelationshipsSpouse relationship list was referenced twice   
               in previous versions.  Corrected to reference the RelationshipsSpouse & RelationshipsDomPartner relationship lists, instead.  
            6> Error Check SP: Updated to not flag error for an employee with > 1 valid deduction code within a Deduction Type, when the   
               DedType allows for multiple deductions.  
            7> Error Check SP: Added error check for Deduction Codes where DedIsCobraCovered = Y, but DedIsBenefit = N when CobraType   
               or UseCobraCoveredDeds parameter is specified.  
1.28      Scott Beever/     2017/05/16    1> COBRA SP: dsi_BDM_sp_ProcessCobraDeductions_V2 cloned from dsi_BDM_sp_ProcessCobraDeductions to encapsulate COBRA   
          Spencer Williams                   enhancements under v1.28  
                                          2> COBRA SP: Add paramaters to pull eepCobraReason, conCobraReason, EepDateOfCobraEvent, ConDateofCobraEvent  
                                             from Platform Configurable Fields  
                                       3> COBRA SP: Add logic to include CobraType = 4  
                           4> COBRA SP: Add logic to include CobraDate = 3  
            5> COBRA SP: Added parameter CobraReasonDepPQB to only set depdendent as PBQ for the reasons specified  
            6> COBRA SP: Moved @CobraIncludeEmps logic to the end of the BDM Cobra Module Logic, to ensure all dependent   
               COBRA logic has been completed before determining EEs that should be included since they have at   
            least 1 valid dependent.       
                                          7> New Enrollee SP: Add New Enrollee option '4' for rehired employees who restart benefits in a previously elected DedCode  
1.29      Spencer Williams/  2018/02/17   1> Added .dbo prefix to object names  
          Scott Beever                    2> Added semicolons throughout script  
                                    3> Suppressed print statements when 'Testing' flag from dbo.U_dsi_Configuration is 'N'  
            4> Removed reference to dbo.U_dsi_BDM_VersionHistory for @Version  
1.30      Spencer Williams   2018/05/03   1> dsi_BDM_sp_PopulateDeductionsTable_v2 cloned from dsi_BDM_sp_PopulateDeductionsTable to allow for future changes without impacting a large  
            number of databases. In this update, the new v2 SP builds the audit tables after dbo.U_dsi_BDM_EmpDeductions and dbo.U_dsi_BDM_DepDeductions  
            are built so that audit data can be created from these tables instead of recalling dbo.fn_BDM_EmpDed() and dbo.fn_BDM_DepBPlan().  
            2> Update to logic to Set dbnBenOptionDate IF @DepFlag = 'Y' and @CalcBenOptionDate = '2'               
      
************************************************************/  
  
  
SET NOCOUNT ON;  
  
  
-----------  
-- Declare variables  
-----------  
  
DECLARE @Version                   VARCHAR(4);  
DECLARE @qFormatCode     VARCHAR(12);  
DECLARE @TempFormatCode            VARCHAR(10);  
DECLARE @TableType                 CHAR(3);  
DECLARE @OEType                    VARCHAR(32);  
DECLARE @IncludeOEDrops            CHAR(1);  
DECLARE @OEPlatform                VARCHAR(32);  
DECLARE @OESessions                VARCHAR(8000);  
DECLARE @TermSelectionOption       VARCHAR(10);  
DECLARE @StartDateTime             DATETIME;  
DECLARE @EndDateTime               DATETIME;  
DECLARE @ExclFutureDatedStartDates VARCHAR(1);  
DECLARE @FutureDatedStartDateDays  INT;  
DECLARE @ExclFutureDatedStopDates  VARCHAR(1);  
DECLARE @FutureDatedStopDateDays   INT;  
DECLARE @GetChangeReason           VARCHAR(1);  
DECLARE @CalcBenOptionDate         CHAR(1);  
DECLARE @OverrideBenStartDate      VARCHAR(1);  
DECLARE @DiscardNonDPDeduction     VARCHAR(1);  
DECLARE @TermsOnly                 VARCHAR(1);  
DECLARE @AllowMultiDedType         VARCHAR(1);  
DECLARE @UseDedStopDate            VARCHAR(1);  
DECLARE @InvalidateBadDeps         VARCHAR(1);  
DECLARE @AddToPreviousRun          VARCHAR(1);  
DECLARE @RunID                     VARCHAR(32);  
DECLARE @BuildConsolidatedTable    VARCHAR(32);  
  
DECLARE @SelectUsingDedTypes       VARCHAR(1);  
DECLARE @DedCodes                  VARCHAR(8000);  
DECLARE @DedTypes                  VARCHAR(8000);  
DECLARE @DedCodesDep               VARCHAR(8000);  
DECLARE @DedTypesDep               VARCHAR(8000);  
DECLARE @DedCodesDP                VARCHAR(8000);  
DECLARE @ManualDedCodes            VARCHAR(1);  
DECLARE @ExcludeDedCodes           VARCHAR(8000);  
DECLARE @UpdDedType             VARCHAR(8000);  
DECLARE @UpdDedCodeType         CHAR(1);  
  
DECLARE @CobraType                 CHAR(1);  
DECLARE @UseCobraCoveredDeds       CHAR(1);  
DECLARE @CobraDate                 CHAR(1);  
DECLARE @EepCobraReasonPCF         VARCHAR(256);  
DECLARE @ConCobraReasonPCF         VARCHAR(256);  
DECLARE @EepDateOfCobraEventPCF    VARCHAR(256);  
DECLARE @ConDateOfCobraEventPCF    VARCHAR(256);  
  
DECLARE @NewEnrolleeType           CHAR(1);  
  
DECLARE @CountDependents           VARCHAR(1);  
DECLARE @RelationshipsSpouse       VARCHAR(256);  
DECLARE @RelationshipsChild        VARCHAR(256);  
DECLARE @RelationshipsDomPartner   VARCHAR(256);  
DECLARE @RelationshipsDPChild      VARCHAR(256);  
  
DECLARE @TestEEIDCnt               INT;  
  
DECLARE @EmpFlag                   VARCHAR(1);  
DECLARE @DepFlag                   VARCHAR(1);  
DECLARE @FutureStartDateLimit      DATETIME;  
DECLARE @FutureStopDateLimit       DATETIME;  
DECLARE @Sql                       VARCHAR(8000);  
DECLARE @Cnt                       INT;  
DECLARE @Temp                      VARCHAR(8000);  
DECLARE @DedRowStatus              VARCHAR(256);  
DECLARE @DedRowType                VARCHAR(32);  
DECLARE @Count                     INT;  
DECLARE @EEStopDateField           VARCHAR(32);  
DECLARE @ModuleStartDateTime       DATETIME;  
DECLARE @ElapsedTime               DATETIME;  
  
DECLARE @OERemoveTermEmps          CHAR(1);  
  
DECLARE @CobraReasonsDepPQB     VARCHAR(8000);  
  
DECLARE @TestingFlag               CHAR(1);  
  
-----------  
-- Set variables  
-----------  
  
SET @ModuleStartDateTime = GETDATE();  
SET @Version             = '1.30'--(Select top 1 isnull(xVersion,0.00) From dbo.U_dsi_BDM_VersionHistory order by xTimestamp desc);  
SET @FormatCode          = dbo.dsi_BDM_fn_Trim(@FormatCode);  
SET @qFormatCode         = '''' + @FormatCode + '''';  
SET @TestingFlag         = isnull(LEFT(dbo.dsi_fnVariable(@FormatCode,'Testing'),1),'');  
  
-----------  
-- Clear timings table  
-----------  
  
DELETE FROM dbo.U_dsi_BDM_Timings  
 WHERE xFormatCode = @FormatCode;  
  
  
-----------  
-- Pull required input parms from configuration table  
-----------  
  
-- DedCodes/types: dedcodes or types comma-delimited format (TC can also populate dbo.U_dsi_BDM_DeductionCodes manually before this process runs)  
-- Will be used for both employees and dependents unless @DedCodesDep/@DedTypesDep is populated  
  
SELECT @DedCodes = CONVERT(VARCHAR(8000), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DedCodes';  
SELECT @DedTypes = CONVERT(VARCHAR(8000), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DedTypes';  
  
  
-- Start and end date/times  
  
SELECT @StartDateTime = CONVERT(DATETIME, ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'StartDateTime';  
SELECT @EndDateTime   = CONVERT(DATETIME, ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'EndDateTime';  
  
  
-- Term Selection Option  
-- <StopDate>   Benefit stop date falls within date range  
-- <AuditDate>  Date benefit stop date is keyed into audit falls within date range  
-- <ActiveOnly> Active only, do not include terms  
  
SELECT @TermSelectionOption  = CONVERT(VARCHAR(32), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'TermSelectionOption';  
  
  
-----------  
-- Pull non-required input parms from configuration table  
-----------  
  
-- TableType: (EMP)loyee, (DEP)endent. Will return both employee and dependent if blank.  
  
SELECT @TableType = CONVERT(CHAR(3), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'TableType';  
  
  
-- GetChangeReason  
-- If set to Y, sets the EedChangeReason to the latest change reason for the dedcode in EmpHDed  
  
SELECT @GetChangeReason = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'GetChangeReason';  
  
  
-- CalcBenOptionDate  
-- <1> - Calculates the EedBenOptionDate for employees, i.e. the effective date their current ben option became active  
-- <2> - Same as above; also copies the EedBenOptionDate to the DbnBenOptionDate field for the dependent/dedcode  
  
SELECT @CalcBenOptionDate = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CalcBenOptionDate';  
  
  
-- OverrideBenStartDate  
-- If set to Y, sets the Eed/DbnBenStartDates to the EedBenOptionDate dated calculated above.  
-- This is very common when exports need to show the date the coverage tier became active as the start date.  
  
SELECT @OverrideBenStartDate = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'OverrideBenStartDate';  
  
  
-- OEType  
-- Populating this parm triggers an OE run  
-- <Active>  Active open enrollment: every employee must re-enroll, only OE records are sent  
-- <Passive> Passive open enrollment: both OE and current records are sent, employees do not need to re-enroll to keep their benefits  
  
SELECT @OEType = CONVERT(VARCHAR(32), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'OEType';  
  
  
-- IncludeOEDrops  
-- If set to N, excludes terms on OE export. Default is to include terms (Y).  
  
SELECT @IncludeOEDrops = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'IncludeOEDrops';  
  
  
-- OESessions  
-- Only used when the customer has bypassed the normal OE process and wants to use pending transactions to load the  
-- OE data. For normal pending transactions you'd just set to PENDING_BI; however, if someone manually loaded the  
-- transactions into the pending tables you would use those session IDs instead.  
  
SELECT @OESessions = CONVERT(VARCHAR(8000), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'OESessions';  
  
  
-- SelectUsingDedTypes (DEPRECATED)  
-- If set to Y, populate deductions based on list of ded types in @DedCodes variable rather than ded codes, e.g. 'MED, DENT'  
-- If blank, will just use dedcodes  
  
-- This parm is deprecated; use the DedTypes parm instead  
  
SELECT @SelectUsingDedTypes = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SelectUsingDedTypes';  
  
  
-- DedCodesDep/DedTypesDep  
-- List of comma-delimited dedcodes or dedtypes used to select dependent deductions  
-- SP will normally just used codes in @DedCodes for both employee and dependent; this would only be populated  
-- if dependents have different dedcodes. This is rare.  
  
SELECT @DedCodesDep = CONVERT(VARCHAR(8000), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DedCodesDep';  
SELECT @DedTypesDep = CONVERT(VARCHAR(8000), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DedTypesDep';  
  
  
-- DedCodesDP  
-- List of comma-delimited domestic partner dedcodes used to select DP deductions  
-- If an employee has both regular and DP deductions, the DP deduction will (usually) be discarded and the regular deduction  
-- will be kept.  
-- NOTE: ALL dedcodes, including DP dedcodes, must be put into the @DedCodes parm so they'll be processed  
  
SELECT @DedCodesDP = CONVERT(VARCHAR(8000), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DedCodesDP';  
  
  
-- ManualDedCodes  
-- If set to Y, SP will not populate the dbo.U_dsi_BDM_DeductionCodes table; allows the TC to do it manually before this process runs,  
-- e.g. select all dedcodes for a certain DedBenPlanProvider, all dedcodes starting with "MM", etc.  
  
SELECT @ManualDedCodes = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'ManualDedCodes';  
  
  
-- ExcludeDedCodes  
-- Excludes dedcode(s). Normally only used when deduction types are being selected and a few dedcodes need to be excluded.  
  
SELECT @ExcludeDedCodes = CONVERT(VARCHAR(8000), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'ExcludeDedCodes';  
  
-- UpdDedType  
-- Updates Dedtype in the dedcode table to = the Dedcode for the dedcode(s) specified  
  
SELECT @UpdDedType = CONVERT(VARCHAR(8000), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'UpdDedType';  
  
-- UpdDedCodeType  
-- Updates Dedtype in the dedcode table to = the Type Specified for the Dedcode  
  
   -- Clear the table  
  
   DELETE FROM dbo.u_dsi_BDM_UpdDedCodes WHERE UFormatCode = @FormatCode;  
  
-- Update flag if values present in config  
SELECT @UpdDedCodeType = 'Y'  
 where exists (select 1 FROM dbo.U_dsi_BDM_Configuration  
     WHERE FormatCode = @FormatCode AND ParmName = 'UpdDedCodeType');  
  
-- populate table  
 insert into dbo.u_dsi_BDM_UpdDedCodes  
 select distinct  
  uformatcode = @FormatCode,  
  udedcode = cast(dbo.dsi_BDM_fn_parsesubfield(dbo.dsi_BDM_fn_Trim(CONVERT(VARCHAR(8000), ParmValue)),',',1) as varchar(10)),  
  udedtype = cast(dbo.dsi_BDM_fn_parsesubfield(dbo.dsi_BDM_fn_Trim(CONVERT(VARCHAR(8000), ParmValue)),',',2) as varchar(32))  
 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'UpdDedCodeType';  
  
  
-- AllowMultiDedType  
-- If set to Y, the SP will allow multiple valid deductions within the same deduction type.  
-- Normally the SP will only allow one deduction per type.  
  
SELECT @AllowMultiDedType = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'AllowMultiDedType';  
  
  
-- TermsOnly  
-- If set to Y, SP will invalidate all active deductions. This is rare and might only be used when an export needs to track  
-- both terms and actives for the same employees.  
  
SELECT @TermsOnly = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'TermsOnly';  
  
  
-- InvalidateBadDeps  
-- If set to Y, SP will invalidate all dependent deductions where 1> an employee deduction doesn't exist or 2> the dependent's  
-- deduction is active and the employee's is termed. This parm should be used with care, as it "hides" bad data.  
  
SELECT @InvalidateBadDeps = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'InvalidateBadDeps';  
  
  
-- UseDedStopDate  
-- If set to Y, SP will determine valid terms based on the EedStopDate rather than the EedBenStopDate.  
-- EedBenStopDate and DbnBenStopDate are ignored.  
  
SELECT @UseDedStopDate = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'UseDedStopDate';  
  
  
-- ExclFutureDatedStartDates  
-- If set to Y, any deduction with a start date after the @EndDateTime is discarded  
-- Usually used when a vendor can't accept future-dated starts  
  
SELECT @ExclFutureDatedStartDates = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'ExclFutureDatedStartDates';  
  
  
-- FutureDatedStartDateDays  
-- Number of days after the @EndDateTime deductions with future-dated start dates will be allowed  
-- For example, if this is set to 60 any deductions with a start date after the @EndDateTime plus 60 days  
-- will be discarded.  
  
SELECT @FutureDatedStartDateDays  = CONVERT(INT, ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'FutureDatedStartDateDays';  
  
  
-- ExclFutureDatedStopDates  
-- If set to Y, any stop dates after the @EndDateTime will be set to NULL and the deduction will be set to active  
-- Usually used when a vendor can't take a future-dated stop, e.g. their system stops the EE immediately even though the  
-- stop date is in the future  
  
SELECT @ExclFutureDatedStopDates  = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'ExclFutureDatedStopDates';  
  
  
-- FutureDatedStopDateDays  
-- Number of days after the @EndDateTime deductions with future-dated stop dates will be sent as stops  
-- For example, if this is set to 60 any deductions with a stop date after the @EndDateTime plus 60 days  
-- will be set to active  
  
SELECT @FutureDatedStopDateDays = CONVERT(INT, ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'FutureDatedStopDateDays';  
  
  
-- DiscardNonDPDeduction  
-- EEs with domestic partners usually have a regular (pre-tax) and domestic partner (post-tax) deduction. Normally  
-- the SP discards the DP deduction and keeps the regular deduction; setting this to Y tells the SP to discard  
-- the regular deduction and keep the DP deduction. This is rare.  
  
SELECT @DiscardNonDPDeduction = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DiscardNonDPDeduction';  
  
  
  
-- CountDependents --  
-- If set to Y, the BDM counts the number of dependents for each EE/dedcode and puts the  
-- number in the EedNumSpouses field, the EedNumChildren field, etc. Usually used when an export needs to  
-- know the number of children for a coverage tier, needs to know if EE has a spouse or domestic partner, etc.  
  
-- NOTE: if this parm is set, the applicable relationship parms below must also be set.  
  
SELECT @CountDependents = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CountDependents';  
  
  
-- Relationship codes, comma-delimited lists of ConRelationships, e.g. CHL, STC  
-- Used for Cobra to determine PQB or for dependent counts  
  
SELECT @RelationshipsSpouse     = CONVERT(VARCHAR(256), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsSpouse';  
SELECT @RelationshipsChild      = CONVERT(VARCHAR(256), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsChild';  
SELECT @RelationshipsDomPartner = CONVERT(VARCHAR(256), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsDomPartner';  
SELECT @RelationshipsDPChild    = CONVERT(VARCHAR(256), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsDPChild';  
  
  
-- AddToPreviousRun  
-- Determines whether the previous run will be preserved  
-- The BDM will not allow > 4 runs for a single formatcode. This is to prevent accidental "runaway" processes where no  
-- run is ever being wiped out.  
  
SELECT @AddToPreviousRun = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'AddToPreviousRun';  
  
  
-- RunID  
-- Sets a unique ID for each run; would usually be used in concert with AddToPreviousRun to distinguish runs.  
-- For example, the first run ID might be "Cobra" and second run ID might be "New Hires".  
  
SELECT @RunID = CONVERT(VARCHAR(32), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RunID';  
  
  
-- BuildConsolidatedTable  
-- Builds a consolidated table of valid employee and dependent deductions for a single formatcode  
-- 1> Standard table  
  
SELECT @BuildConsolidatedTable = CONVERT(VARCHAR(32), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'BuildConsolidatedTable';  
  
  
-- CobraType  
-- Determines whether this is a Cobra run  
  
SELECT @CobraType = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CobraType';  
  
-- CobraDate  
SELECT @CobraDate = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CobraDate';  
  
-- Pull eepCobraReason, conCobraReason, EepDateOfCobraEvent, ConDateofCobraEvent from Platform Configurable Fields  
SELECT @EepCobraReasonPCF = CONVERT(VARCHAR(256), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'EepCobraReasonPCF';  
SELECT @ConCobraReasonPCF = CONVERT(VARCHAR(256), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'ConCobraReasonPCF';  
SELECT @EepDateOfCobraEventPCF = CONVERT(VARCHAR(256), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'EepDateOfCobraEventPCF';  
SELECT @ConDateOfCobraEventPCF = CONVERT(VARCHAR(256), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'ConDateOfCobraEventPCF';  
  
  
-- UseCobraCoveredDeds  
-- Determines whether to select dedcodes using DedIsCobraCovered  
-- Blank - If set as a cobra run then BDM will set this param to be Y by default (i.e. if param was not used) and will select all dedcodes where DedIsCobraCovered = Y (ignoring Dedcodes and/or types specified per below).  
-- Y - use only dedcodes with DedIsCobraCovered = Y. BDM ignores Dedcodes and/or types specified.  Only deductions in which DedIsCobraCovered = Y are selected.   
-- N - use only dedcodes with DedIsCobraCovered <> Y. BDM selects Dedcodes and/or types specified and then only returns deduction from this list where DedIsCobraCovered <> Y.   
-- A - use specified dedcodes for Cobra runs regardless of value in DedIsCobraCovered  
-- X - use only dedcodes with DedIsCobraCovered = Y. BDM selects Dedcodes and/or types specified and then only returns deductions from this list where DedIsCobraCovered = Y  
  
SELECT @UseCobraCoveredDeds = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'UseCobraCoveredDeds';  
  
  
-- NewEnrolleeType  
-- Determines whether this is a New Enrollee run  
  
SELECT @NewEnrolleeType = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'NewEnrolleeType';  
  
  
-- Are Test EEIDs being used?  
  
SELECT @TestEEIDCnt = COUNT(1) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'TestEEID';  
  
IF @TestEEIDCnt > 0 BEGIN  
   PRINT '>>>';  
   PRINT '>>>';  
   PRINT '>>> WARNING... test EEIDs are being used by this module <<<';  
   PRINT '>>>';  
   PRINT '>>>';  
END;  
  
-- OERemoveTermEmps  
-- If set to N, includes terminated employees on OE export. Default is actives only (Based on dbo.EmpComp.EecEmplStatus).  
  
SELECT @OERemoveTermEmps = CONVERT(VARCHAR(1), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'OERemoveTermEmps';  
  
-- CobraReasonsDepPQB  
  
SELECT @CobraReasonsDepPQB = CONVERT(VARCHAR(8000), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CobraReasonsDepPQB';  
  
  
-----------  
-- Look for invalid parms  
-----------  
  
SELECT @Cnt = COUNT(1)  
  FROM dbo.U_dsi_BDM_Configuration  
 WHERE FormatCode = @FormatCode  
   AND ParmName NOT IN ('AddToPreviousRun',  
                        'AllowMultiDedType',  
                        'BuildConsolidatedTable',  
                        'CalcBenOptionDate',  
                        'CobraDate',  
                        'CobraIncludeEmps',  
                        'CobraPQBType',  
                        'CobraPQBMulti',  
                        'CobraReasonsDep',  
                        'CobraReasonsEmp',  
                        'CobraType',  
                        'CountDependents',  
                        'DedCodes',  
                        'DedCodesDP',  
                        'DedCodesDep',  
                        'DedTypes',  
                        'DedTypesDep',  
                        'DiscardNonDPDeduction',  
                        'EndDateTime',  
                        'ExclFutureDatedStartDates',  
                        'ExclFutureDatedStopDates',  
                        'ExcludeDedCodes',  
                        'FutureDatedStartDateDays',  
                        'FutureDatedStopDateDays',  
                        'GetChangeReason',  
                        'IncludeOEDrops',  
                        'InvalidCobraReasonsDep',  
                        'InvalidCobraReasonsEmp',  
                        'InvalidTermReasonsDep',  
                        'InvalidTermReasonsEmp',  
                        'InvalidateBadDeps',  
                        'ManualCobraReasons',  
                        'ManualDedCodes',  
                        'NewEnrolleeDeps',  
                        'NewEnrolleeExcludeDeps',  
                        'NewEnrolleeIncludeEmps',  
                        'NewEnrolleeType',  
                        'OESessions',  
                        'OEType',  
                        'OverrideBenStartDate',  
                        'RelationshipsChild',  
                        'RelationshipsDPChild',  
                        'RelationshipsDomPartner',  
                        'RelationshipsSpouse',  
                        'RunID',  
                        'SelectUsingDedTypes',  
                        'StartDateTime',  
                        'TableType',  
                        'TermSelectionOption',  
                        'TermsOnly',  
                        'TestEEID',  
                        'UseCobraCoveredDeds',  
                        'UseDedStopDate',  
      'UpdDedCodeType',  
      'UpdDedType',  
      'OERemoveTermEmps',  
      'BdmAddField',  
      'EepCobraReasonPCF',  
      'ConCobraReasonPCF',  
      'EepDateOfCobraEventPCF',  
      'ConDateOfCobraEventPCF',  
      'CobraReasonsDepPQB'  
      );  
  
IF @Cnt > 0 BEGIN  
   PRINT '>>>';  
   PRINT '>>>';  
   PRINT '>>> WARNING... one or more parms in the dbo.U_dsi_BDM_Configuration table is unrecognized by this module <<<';  
   PRINT '>>>';  
   PRINT '>>>';  
END;  
  
  
-----------  
-- Trim and coalesce input parms  
-----------  
  
  
SET @AddToPreviousRun          = dbo.dsi_BDM_fn_Trim(@AddToPreviousRun);  
SET @AllowMultiDedType         = dbo.dsi_BDM_fn_Trim(@AllowMultiDedType);  
SET @BuildConsolidatedTable    = dbo.dsi_BDM_fn_Trim(@BuildConsolidatedTable);  
SET @CalcBenOptionDate         = dbo.dsi_BDM_fn_Trim(@CalcBenOptionDate);  
SET @CountDependents           = dbo.dsi_BDM_fn_Trim(@CountDependents);  
SET @DedCodes                  = dbo.dsi_BDM_fn_Trim(@DedCodes);  
SET @DedCodesDP                = dbo.dsi_BDM_fn_Trim(@DedCodesDP);  
SET @DedCodesDep  = dbo.dsi_BDM_fn_Trim(@DedCodesDep);  
SET @DedTypes                  = dbo.dsi_BDM_fn_Trim(@DedTypes);  
SET @DedTypesDep               = dbo.dsi_BDM_fn_Trim(@DedTypesDep);  
SET @DiscardNonDPDeduction     = dbo.dsi_BDM_fn_Trim(@DiscardNonDPDeduction);  
SET @ExclFutureDatedStartDates = dbo.dsi_BDM_fn_Trim(@ExclFutureDatedStartDates);  
SET @ExclFutureDatedStopDates  = dbo.dsi_BDM_fn_Trim(@ExclFutureDatedStopDates);  
SET @ExcludeDedCodes           = dbo.dsi_BDM_fn_Trim(@ExcludeDedCodes);  
SET @FutureDatedStartDateDays  = dbo.dsi_BDM_fn_Trim(@FutureDatedStartDateDays);  
SET @FutureDatedStopDateDays   = dbo.dsi_BDM_fn_Trim(@FutureDatedStopDateDays);  
SET @GetChangeReason           = dbo.dsi_BDM_fn_Trim(@GetChangeReason);  
SET @IncludeOEDrops            = dbo.dsi_BDM_fn_Trim(@IncludeOEDrops);  
SET @InvalidateBadDeps         = dbo.dsi_BDM_fn_Trim(@InvalidateBadDeps);  
SET @ManualDedCodes            = dbo.dsi_BDM_fn_Trim(@ManualDedCodes);  
SET @OESessions                = dbo.dsi_BDM_fn_Trim(@OESessions);  
SET @OEType                    = dbo.dsi_BDM_fn_Trim(@OEType);  
SET @OverrideBenStartDate      = dbo.dsi_BDM_fn_Trim(@OverrideBenStartDate);  
SET @RelationshipsChild        = dbo.dsi_BDM_fn_Trim(@RelationshipsChild);  
SET @RelationshipsDPChild      = dbo.dsi_BDM_fn_Trim(@RelationshipsDPChild);  
SET @RelationshipsDomPartner   = dbo.dsi_BDM_fn_Trim(@RelationshipsDomPartner);  
SET @RelationshipsSpouse       = dbo.dsi_BDM_fn_Trim(@RelationshipsSpouse);  
SET @RunID                     = dbo.dsi_BDM_fn_Trim(@RunID);  
SET @SelectUsingDedTypes       = dbo.dsi_BDM_fn_Trim(@SelectUsingDedTypes);  
SET @TableType                 = dbo.dsi_BDM_fn_Trim(@TableType);  
SET @TermSelectionOption       = dbo.dsi_BDM_fn_Trim(@TermSelectionOption);  
SET @TermsOnly                 = dbo.dsi_BDM_fn_Trim(@TermsOnly);  
SET @UseCobraCoveredDeds       = dbo.dsi_BDM_fn_Trim(@UseCobraCoveredDeds);  
SET @UseDedStopDate            = dbo.dsi_BDM_fn_Trim(@UseDedStopDate);  
SET @UpdDedType             = dbo.dsi_BDM_fn_Trim(@UpdDedType);  
SET @OERemoveTermEmps        = dbo.dsi_BDM_fn_Trim(@OERemoveTermEmps);  
SET @CobraDate                 = dbo.dsi_BDM_fn_Trim(@CobraDate);  
SET @EepCobraReasonPCF         = dbo.dsi_BDM_fn_Trim(@EepCobraReasonPCF);  
SET @ConCobraReasonPCF         = dbo.dsi_BDM_fn_Trim(@ConCobraReasonPCF);  
SET @EepDateOfCobraEventPCF    = dbo.dsi_BDM_fn_Trim(@EepDateOfCobraEventPCF);  
SET @ConDateOfCobraEventPCF    = dbo.dsi_BDM_fn_Trim(@ConDateOfCobraEventPCF);  
SET @CobraReasonsDepPQB        = dbo.dsi_BDM_fn_Trim(@CobraReasonsDepPQB);  
  
  
-----------  
-- Set the stop date name  
-----------  
  
SET @EEStopDateField = 'EedBenStopDate';  
IF @UseDedStopDate = 'Y' BEGIN  
   SET @EEStopDateField = 'EedStopDate';  
END;  
  
  
-----------  
-- Default the UseCobraCoveredDeds parm for Cobra runs  
-----------  
  
-- If UseCobraCoveredDeds isn't set and it's a Cobra run, set it to Y.  
  
IF @UseCobraCoveredDeds = '' AND @CobraType <> '' BEGIN  
   SET @UseCobraCoveredDeds = 'Y';  
END;  
  
  
-----------  
-- Determine the OE platform  
-----------  
  
-- Determines the type of OE the client is using  
-- <ASP>  Client using ASP for OE  
-- <NET>  Client using .NET for OE  
  
IF @OEType <> '' BEGIN  
  
   SELECT @OEPlatform = CASE WHEN dbo.dsi_BDM_fn_Trim(a.PrkProdCode) = 'NETOE' and @OESessions = '' THEN 'NET' ELSE 'ASP' END  
     FROM dbo.Compmast  
     LEFT JOIN RbsProductKeys a on a.PrkProdCode = 'NETOE';  
  
  
   -- Set the effective date for .Net OE  
  
   IF @OEPlatform = 'NET' BEGIN  
  
      EXEC MASTER.dbo.CXN_SET_SESSION_DATE @EndDateTime;  
  
   END;  
  
END;  
  
  
-----------  
-- Override input parms for Open Enrollment runs  
-----------  
  
-- OE runs set all parms to their default values.  
  
IF @OEType <> '' BEGIN  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT '*** NOTE: as this is an OE run, input parms will be set to their default values.';  
   PRINT '';  
   END;    
   SET @TermSelectionOption       = 'StopDate'; -- use date range only, no audit  
   SET @ExclFutureDatedStartDates = 'N';        -- no future start or stop dates are excluded  
   SET @FutureDatedStartDateDays  = '';         -- there is no upper limit on future start or stop Dates  
   SET @ExclFutureDatedStopDates  = 'N';        -- no future start or stop dates are excluded  
   SET @FutureDatedStopDateDays   = '';         -- there is no upper limit on future start or stop Dates  
END;  
  
  
-----------  
-- Populate dbo.U_dsi_BDM_Sessions table with OE or pending sessions  
-----------  
  
DELETE FROM dbo.U_dsi_BDM_Sessions  
 WHERE BdsFormatCode = @FormatCode;  
  
  
-- Open Enrollment sessions  
  
IF @OEType <> '' AND @OESessions = '' BEGIN  
  
   INSERT INTO dbo.U_dsi_BDM_Sessions  
   SELECT @FormatCode, 'O', OesCode  
     FROM OESetup  
    WHERE OesStatus = 'L'  
      AND OesPlanYear = YEAR(@EndDateTime);  
  
END;  
  
  
-- Pending sessions  
  
IF @OEType <> '' AND @OESessions <> '' BEGIN  
  
   INSERT INTO dbo.U_dsi_BDM_Sessions  
   SELECT @FormatCode, 'P', item  
     FROM dbo.dsi_BDM_fn_ListToTable(@OESessions);  
  
END;  
  
  
-----------  
-- Print input variables  
-----------  
IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
BEGIN  
  
PRINT '';  
PRINT '*** dsi_BDM_sp_PopulateDeductionsTable ***';  
PRINT '';  
  
PRINT 'Version:                             ' + @Version;  
PRINT 'Table type:                          ' + CASE  
                                                   WHEN @TableType = ''    THEN 'Employee & Dependent'  
                                                   WHEN @TableType = 'EMP' THEN 'Employee'  
                                                   WHEN @TableType = 'DEP' THEN 'Dependent'  
                                                END;  
PRINT 'Run type:                            ' + CASE  
                                                   WHEN @CobraType <> ''       THEN 'Cobra run'  
                                                   WHEN @NewEnrolleeType <> '' THEN 'New enrollee run'  
                                                   WHEN @OEType = ''           THEN 'Regular run'  
                                                   WHEN @OEType = 'Active'     THEN 'Active OE'  
                                                   WHEN @OEType = 'Passive'    THEN 'Passive OE'  
                                                END;  
  
IF @OEPlatform <> '' BEGIN  
   PRINT 'OE platform:                         ' + CASE  
                                                      WHEN @OEPlatform = 'ASP' THEN 'ASP'  
                                                      WHEN @OEPlatform = 'NET' THEN '.NET'  
                                                      ELSE ''  
                                                   END;  
END;  
  
PRINT 'Dedcodes:                            ' + @DedCodes;  
PRINT 'Dedtypes:                            ' + @DedTypes;  
  
IF @SelectUsingDedTypes <> '' PRINT 'Based on dedcode or dedtype:         DedType';  
IF @DedCodesDP <> ''          PRINT 'Domestic partner dedcodes/types:     ' + @DedCodesDP;  
IF @DedCodesDep <> ''         PRINT 'Dependent Dedcodes:                  ' + @DedCodesDep;  
IF @DedTypesDep <> ''         PRINT 'Dependent Dedtypes                   ' + @DedTypesDep;  
  
  
PRINT 'Term selection option:               ' + CASE  
                                                   WHEN @TermSelectionOption = 'StopDate'   THEN 'Benefit stop date'  
                                                   WHEN @TermSelectionOption = 'AuditDate'  THEN 'Date benefit stop date is keyed into audit'  
                                                   WHEN @TermSelectionOption = 'ActiveOnly' THEN 'Active only, do not include terms'  
                                                END;  
PRINT 'Start date time:                     ' + CONVERT(VARCHAR(32), @StartDateTime);  
PRINT 'End date time:                       ' + CONVERT(VARCHAR(32), @EndDateTime);  
PRINT 'Exclude future start dates:          ' + @ExclFutureDatedStartDates;  
PRINT 'Num days to show future start dates: ' + CONVERT(VARCHAR(32), @FutureDatedStartDateDays);  
PRINT 'Exclude future stop dates:           ' + @ExclFutureDatedStopDates;  
PRINT 'Num days to show future stop dates:  ' + CONVERT(VARCHAR(32), @FutureDatedStopDateDays);  
PRINT 'Benefits start date:                 ' + CASE  
                                                   WHEN @CalcBenOptionDate = ''  THEN 'EedBenStartDate'  
                                                   WHEN @CalcBenOptionDate = '1' THEN 'Start date for employee''s latest benefit option (employee only is updated)'  
                                                   WHEN @CalcBenOptionDate = '2' THEN 'Start date for employee''s latest benefit option (employee and dependent records are updated)'  
                                                   ELSE 'Not set'  
                                                END;  
                                                  
IF @RelationshipsSpouse <> '' OR @RelationshipsChild <> '' OR @RelationshipsDomPartner <> '' OR @RelationshipsDPChild <> '' BEGIN  
   PRINT 'Spouse relationship codes:           ' + @RelationshipsSpouse;  
   PRINT 'Child relationship codes:            ' + @RelationshipsChild;  
   PRINT 'Dom partner relationship codes:      ' + @RelationshipsDomPartner;  
   PRINT 'DP child relationship codes:         ' + @RelationshipsDPChild;  
END;  
  
PRINT '';  
END;  
  
-----------  
-- Check for required parms  
-----------  
  
IF @TableType NOT IN ('EMP', 'DEP', '') BEGIN  
   RAISERROR ('Table type not set to EMP, DEP or blank.', 11, 1);  
   RETURN;  
END;  
  
IF @OEType NOT IN ('', 'Passive', 'Active') BEGIN  
   RAISERROR ('OE type not set to blank, Passive or Active.', 11, 1);  
   RETURN;  
END;  
  
IF @TermSelectionOption NOT IN ('StopDate', 'AuditDate', 'ActiveOnly') BEGIN  
   RAISERROR ('Term selection option not set to StopDate, AuditDate, or ActiveOnly.', 11, 1);  
   RETURN;  
END;  
  
IF @StartDateTime IS NULL BEGIN  
   RAISERROR ('Start date/time is NULL.', 11, 1);  
   RETURN;  
END;  
  
IF @EndDateTime IS NULL BEGIN  
   RAISERROR ('End date/time is NULL.', 11, 1);  
   RETURN;  
END;  
  
  
-----------  
-- Set update flags  
-----------  
  
SET @EmpFlag = CASE WHEN @TableType IN ('EMP', '') THEN 'Y' ELSE 'N' END;  
SET @DepFlag = CASE WHEN @TableType IN ('DEP', '') THEN 'Y' ELSE 'N' END;  
  
  
-----------  
-- Populate the dbo.U_dsi_BDM_EEList table  
-----------  
  
-- We copy the existing EEList into a standard table so we don't have to write a lot of dynamic code later on.  
  
DELETE FROM dbo.U_dsi_BDM_EEList WHERE xFormatCode = @FormatCode;  
  
SET @Sql =        'INSERT INTO dbo.U_dsi_BDM_EEList ';  
SET @Sql = @Sql + ' SELECT ' + @qFormatCode + ', xCOID, xEEID FROM dbo.U_' + @FormatCode + '_EEList WITH (NOLOCK)';  
  
--PRINT @Sql  
EXEC(@Sql);  
  
IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
BEGIN  
PRINT CONVERT(VARCHAR(6), @@ROWCOUNT) + ' records inserted into dbo.U_dsi_BDM_EEList';  
PRINT '';  
END;  
  
-----------  
-- Clear EEList if test EEIDs are being used  
-----------  
  
IF @TestEEIDCnt > 0 BEGIN  
  
   DELETE FROM dbo.U_dsi_BDM_EEList  
    WHERE xFormatCode = @FormatCode  
      AND xEEID NOT IN (SELECT ParmValue FROM dbo.U_dsi_BDM_Configuration  
                         WHERE FormatCode = @FormatCode  
                           AND ParmName = 'TestEEID');  
  
END;  
  
  
-----------  
-- Set the limit dates for future-dated start and stop dates, if necessary  
-----------  
  
-- Start dates  
  
SET @FutureStartDateLimit = NULL;  
IF @ExclFutureDatedStartDates <> 'Y' AND @FutureDatedStartDateDays <> '' BEGIN  
   SET @FutureStartDateLimit = @EndDateTime + @FutureDatedStartDateDays;  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT 'Future start date limit set to: ' + CONVERT(VARCHAR(32), @FutureStartDateLimit);  
   END;  
END;  
  
  
-- Stop dates  
  
SET @FutureStopDateLimit = NULL;  
IF @ExclFutureDatedStopDates <> 'Y' AND @FutureDatedStopDateDays <> '' BEGIN  
   SET @FutureStopDateLimit = @EndDateTime + @FutureDatedStopDateDays;  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT 'Future stop date limit set to:  ' + CONVERT(VARCHAR(32), @FutureStopDateLimit);  
   END;  
END;  
  
  
-----------  
-- Populate the deduction code table  
-----------  
  
IF @ManualDedCodes <> 'Y' BEGIN  
  
   -- If no dependent dedcodes are specified, use the employee dedcodes/dedtypes  
  
   IF @DedCodesDep = '' SET @DedCodesDep = @DedCodes;  
   IF @DedTypesDep = '' SET @DedTypesDep = @DedTypes;  
  
  
   -- If using the SelectUsingDedTypes parm, copy the dedcodes into the DedTypes parm  
   -- NOTE: this parm is deprecated; DedTypes parm should be used instead  
  
   IF @SelectUsingDedTypes <> '' BEGIN  
      SET @DedTypes = @DedCodes;  
      SET @DedCodes = '';  
  
      SET @DedTypesDep = @DedCodesDep;  
      SET @DedCodesDep = '';  
   END;  
  
  
   -- Clear the table  
  
   DELETE FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode;  
  
  
   -- Populate for employees  
  
   INSERT INTO dbo.U_dsi_BDM_DeductionCodes  
   SELECT @FormatCode, 'EMP', DedDedCode, DedDedType, 'N'  
     FROM dbo.Dedcode  
     LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@DedCodes) d ON d.item = DedDedCode  
     LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@DedTypes) t ON t.item = DedDedType  
    WHERE (d.item IS NOT NULL OR t.item IS NOT NULL)  
      AND @UseCobraCoveredDeds NOT IN ('Y','N')  
    GROUP BY DedDedCode, DedDedType;  
      
         
   -- Populate for dependents  
  
   INSERT INTO dbo.U_dsi_BDM_DeductionCodes  
   SELECT @FormatCode, 'DEP', DedDedCode, DedDedType, 'N'  
     FROM dbo.Dedcode  
     LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@DedCodesDep) d ON d.item = DedDedCode  
     LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@DedTypesDep) t ON t.item = DedDedType  
    WHERE (d.item IS NOT NULL OR t.item IS NOT NULL)  
      AND @UseCobraCoveredDeds NOT IN ('Y','N')  
    GROUP BY DedDedCode, DedDedType;  
      
          
   -- If Cobra Run and no ded codes/types are specified, populate all ded codes.   
   -- The @DedCodes and/or @DedTypes filtering will be ignored if @UseCobraCoveredDeds IN ('Y','N').  This allows for backward-compatability from v1.20 to v1.21  
   -- A delete statment below will then filter these down based on the DedIsCobraCovered values  
     
   INSERT INTO dbo.U_dsi_BDM_DeductionCodes  
   SELECT @FormatCode, 'EMP', DedDedCode, DedDedType, 'N'  
     FROM dbo.Dedcode  
    WHERE (@CobraType <> '' OR @NewEnrolleeType <> '')  
      AND ((@DedCodes = '' AND @DedTypes = '') OR @UseCobraCoveredDeds IN ('Y','N'));  
  
   INSERT INTO dbo.U_dsi_BDM_DeductionCodes  
   SELECT @FormatCode, 'DEP', DedDedCode, DedDedType, 'N'  
     FROM dbo.Dedcode  
    WHERE (@CobraType <> '' OR @NewEnrolleeType <> '')  
      AND ((@DedCodesDep = '' AND @DedTypesDep = '') OR @UseCobraCoveredDeds IN ('Y','N'));  
        
   
   -- Set flags for domestic partner dedcodes  
  
   UPDATE dbo.U_dsi_BDM_DeductionCodes  
      SET UdcIsDomPartnerDed = 'Y'  
     FROM dbo.dsi_BDM_fn_ListToTable(@DedCodesDP)  
     JOIN dbo.U_dsi_BDM_DeductionCodes WITH (NOLOCK) ON UdcFormatCode = @FormatCode AND UdcDedCode = item;  
  
  
  
   -- If the @UseCobraCoveredDeds parm is set, keep only the appropriate dedcodes  
   -- If the A option is set, no action is needed  
  
   DELETE FROM dbo.U_dsi_BDM_DeductionCodes  
     FROM dbo.U_dsi_BDM_DeductionCodes  
     JOIN dbo.Dedcode WITH (NOLOCK) ON DedDedCode = UdcDedCode  
    WHERE UdcFormatCode = @FormatCode  
      AND DedIsCobraCovered <> 'Y'  
      AND @UseCobraCoveredDeds in ('X','Y');  
  
   DELETE FROM dbo.U_dsi_BDM_DeductionCodes  
     FROM dbo.U_dsi_BDM_DeductionCodes  
     JOIN dbo.Dedcode WITH (NOLOCK) ON DedDedCode = UdcDedCode  
    WHERE UdcFormatCode = @FormatCode  
      AND DedIsCobraCovered = 'Y'  
      AND @UseCobraCoveredDeds = 'N';  
  
  
   -- If the @ExcludeDedCodes parm is set, delete the appropriate dedcodes  
  
   DELETE FROM dbo.U_dsi_BDM_DeductionCodes  
     FROM dbo.U_dsi_BDM_DeductionCodes  
     JOIN dbo.dsi_BDM_fn_ListToTable(@ExcludeDedCodes) d ON d.item = UdcDedCode  
    WHERE UdcFormatCode = @FormatCode  
      AND @ExcludeDedCodes <> '';  
  
 -- If the @UpdDedType parm is set, update the dedtype on the dedcodes specified to equal the dedcode  
  
  UPDATE dbo.U_dsi_BDM_DeductionCodes  
  SET UdcDedType = UdcDedCode  
     FROM dbo.U_dsi_BDM_DeductionCodes  
     JOIN dbo.dsi_BDM_fn_ListToTable(@UpdDedType) d ON d.item = UdcDedType  
    WHERE UdcFormatCode = @FormatCode  
      AND @UpdDedType <> '';  
  
 -- If the @UpdDedCodeType parm is set, update the dedtype on the dedcodes specified to equal the specified dedtype  
  
  UPDATE dbo.U_dsi_BDM_DeductionCodes  
  SET UdcDedType = uDedType  
     FROM dbo.U_dsi_BDM_DeductionCodes  
     JOIN dbo.u_dsi_BDM_UpdDedCodes  ON uDedCode = udcDedCode and uFormatCode = udcFormatcode  
    WHERE UdcFormatCode = @FormatCode  
      AND @UpdDedCodeType <> '';  
  
END;  
  
  
-----------  
-- Warn on invalid dedcodes  
-----------  
  
SET @Temp = '';  
SELECT @Temp = @Temp + RTRIM(UdcDedCode) + ','  
  
FROM dbo.U_dsi_BDM_DeductionCodes  
LEFT JOIN dbo.DedCode ON DedDedCode = UdcDedCode  
WHERE UdcFormatCode = @FormatCode  
  AND UdcDedCode IS NULL;  
  
IF @Temp <> '' BEGIN  
   PRINT '>>>';  
   PRINT '>>>';  
   PRINT '>>> WARNING: deduction codes not found in target system: ' + LEFT(@Temp, LEN(@Temp) -1);  
   PRINT '>>>';  
   PRINT '>>>';  
END;  
  
  
-----------  
-- Clear any current audit entries  
-----------  
  
Truncate Table dbo.U_dsi_BDM_Audit;  
Truncate Table dbo.U_dsi_BDM_Audit_Future;  
  
  
/*  
IF @EmpFlag = 'Y' BEGIN  
   DELETE FROM dbo.U_dsi_BDM_Audit        WHERE AudFormatCode = @FormatCode AND AudTarget = 'EMP'  
   DELETE FROM dbo.U_dsi_BDM_Audit_Future WHERE AudFormatCode = @FormatCode AND AudTarget = 'EMP'  
END  
  
IF @DepFlag = 'Y' BEGIN  
   DELETE FROM dbo.U_dsi_BDM_Audit        WHERE AudFormatCode = @FormatCode AND AudTarget = 'DEP'  
   DELETE FROM dbo.U_dsi_BDM_Audit_Future WHERE AudFormatCode = @FormatCode AND AudTarget = 'DEP'  
END  
*/  
  
-----------  
-- Populate audit table for employees  
-----------  
  
IF @EmpFlag = 'Y'  AND @TermSelectionOption = 'AuditDate' BEGIN  
  
   INSERT INTO dbo.U_dsi_BDM_Audit  
   SELECT DISTINCT  
  
   @FormatCode,  
   'EMP',  
   AudKey1Value,  
   AudKey2Value,  
   AudKey3Value,  
   AudTableName,  
   AudFieldName,  
   AudOldValue,  
   AudNewValue,  
   AudDateTime,  
   AudProcessedDateTime,  
   AudEffectiveDate,  
   AudSystemID  
  
   FROM dbo.U_dsi_BDM_EEList  
   JOIN dbo.vw_auditdata WITH (NOLOCK) ON AudKey1Value = xEEID   
   JOIN dbo.U_dsi_BDM_DeductionCodes ON AudKey3Value = UdcDedCode and UdcFormatCode = xFormatCode   
   LEFT JOIN dbo.fn_BDM_EmpDed(@FormatCode) ON xEEID = EedEEID and xCOID = EedCOID and AudKey3Value = EedDedCode  
   WHERE   
     AudTableName = 'EmpDed'   
     AND ((@UseDedStopDate = 'Y' AND AudFieldName = @EEStopDateField)   
            OR (@UseDedStopDate <> 'Y' AND audFieldName = CASE WHEN isnull(DedIsBenefit,'') <> 'Y' THEN 'eedStopDate' ELSE 'eedBenStopDate' END))  
     AND UdcDedTarget = 'EMP'  
     AND isnull( EedBenStatus,'') <> 'W'  
     AND AudNewValue IS NOT NULL  
     AND xFormatCode = @FormatCode  
     AND  
     (   
     (AudProcessedDateTime BETWEEN @StartDateTime AND @EndDateTime) OR  
     (AudEffectiveDate     BETWEEN @StartDateTime AND @EndDateTime  
  and AudEffectiveDate > audProcessedDateTime)  
     );  
     
   SELECT @Cnt = COUNT(1) FROM dbo.U_dsi_BDM_Audit  
    WHERE AudFormatCode = @FormatCode  
      AND AudTarget = 'EMP';  
  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT '';  
   PRINT CONVERT(VARCHAR(6), @Cnt) + ' employee records inserted into dbo.U_dsi_BDM_Audit';  
   END;  
  
  
   -- Build future audit entries. Benefits exports may look at audit entries dated after the date range.  
   -- Putting these entries in their own table can drastically increase performance.  
  
  
   INSERT INTO dbo.U_dsi_BDM_Audit_Future  
   SELECT DISTINCT  
  
   @FormatCode,  
   'EMP',  
   AudKey1Value,  
   AudKey2Value,  
   AudKey3Value,  
   AudTableName,  
   AudFieldName,  
   AudOldValue,  
   AudNewValue,  
   AudDateTime,  
   AudProcessedDateTime,  
   AudEffectiveDate,  
   AudSystemID  
  
   FROM dbo.U_dsi_BDM_EEList  
   JOIN dbo.vw_auditdata WITH (NOLOCK) ON AudKey1Value = xEEID   
   JOIN dbo.U_dsi_BDM_DeductionCodes ON AudKey3Value = UdcDedCode AND UdcFormatCode = xFormatCode  
   LEFT JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = UdcDedCode  
   WHERE AudProcessedDateTime > @EndDateTime  
     AND AudTableName = 'EmpDed'   
     AND ((@UseDedStopDate = 'Y' AND AudFieldName = @EEStopDateField)   
            OR (@UseDedStopDate <> 'Y' AND audFieldName = CASE WHEN isnull(DedIsBenefit,'') <> 'Y' THEN 'eedStopDate' ELSE 'eedBenStopDate' END))   
     AND UdcDedTarget = 'EMP'  
     AND AudNewValue IS NOT NULL  
     AND xFormatCode = @FormatCode;  
  
   SELECT @Cnt = COUNT(1) FROM dbo.U_dsi_BDM_Audit_Future  
    WHERE AudFormatCode = @FormatCode  
      AND AudTarget = 'EMP';  
  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT '';  
   PRINT CONVERT(VARCHAR(6), @Cnt) + ' employee records inserted into dbo.U_dsi_BDM_Audit_Future';  
   END;  
  
  
END;  
  
  
-----------  
-- Populate audit table for dependents  
-----------  
  
IF @DepFlag = 'Y'  AND @TermSelectionOption = 'AuditDate' BEGIN  
  
   INSERT INTO dbo.U_dsi_BDM_Audit  
   SELECT DISTINCT  
  
   @FormatCode,  
   'DEP',  
   AudKey1Value,  
   AudKey2Value,  
   AudKey3Value,  
   AudTableName,  
   AudFieldName,  
   AudOldValue,  
   AudNewValue,  
   AudDateTime,  
   AudProcessedDateTime,  
   AudEffectiveDate,  
   AudSystemID  
  
   FROM dbo.U_dsi_BDM_EEList  
   JOIN dbo.vw_auditdata WITH (NOLOCK) ON AudKey1Value = xEEID   
   JOIN dbo.U_dsi_BDM_DeductionCodes ON AudKey2Value = UdcDedCode and UdcFormatCode = xFormatCode   
   LEFT JOIN dbo.fn_BDM_DepBPlan (@FormatCode) ON xEEID = dbnEEID and AudKey2Value = dbnDedCode  
   WHERE  
     AudTableName = 'DepBPlan'   
     AND AudFieldName = 'DbnBenStopDate'   
     AND UdcDedTarget = 'DEP'  
     AND isnull(dbnBenStatus,'') <> 'W'  
     AND AudNewValue IS NOT NULL  
     AND xFormatCode = @FormatCode  
     AND  
     (   
     (AudProcessedDateTime BETWEEN @StartDateTime AND @EndDateTime) OR  
     (AudEffectiveDate     BETWEEN @StartDateTime AND @EndDateTime  
  and AudEffectiveDate > audProcessedDateTime)  
     );  
  
   SELECT @Cnt = COUNT(1) FROM dbo.U_dsi_BDM_Audit  
    WHERE AudFormatCode = @FormatCode  
      AND AudTarget = 'DEP';  
  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT '';  
   PRINT CONVERT(VARCHAR(6), @Cnt) + ' dependent records inserted into dbo.U_dsi_BDM_Audit';  
   END;  
  
   -- Build future audit entries. Benefits exports may look at audit entries dated after the date range.  
   -- Putting these entries in their own table can drastically increase performance.  
  
   INSERT INTO dbo.U_dsi_BDM_Audit_Future  
   SELECT DISTINCT  
  
   @FormatCode,  
   'DEP',  
   AudKey1Value,  
   AudKey2Value,  
   AudKey3Value,  
   AudTableName,  
   AudFieldName,  
   AudOldValue,  
   AudNewValue,  
   AudDateTime,  
   AudProcessedDateTime,  
   AudEffectiveDate,  
   AudSystemID  
  
   FROM dbo.U_dsi_BDM_EEList  
   JOIN dbo.vw_auditdata WITH (NOLOCK) ON AudKey1Value = xEEID   
   JOIN dbo.U_dsi_BDM_DeductionCodes ON AudKey2Value = UdcDedCode AND UdcFormatCode = xFormatCode  
   WHERE AudProcessedDateTime > @EndDateTime  
     AND AudTableName = 'DepBPlan'   
     AND AudFieldName = 'DbnBenStopDate'   
     AND UdcDedTarget = 'DEP'  
     AND AudNewValue IS NOT NULL  
     AND xFormatCode = @FormatCode;  
  
   SELECT @Cnt = COUNT(1) FROM dbo.U_dsi_BDM_Audit_Future  
    WHERE AudFormatCode = @FormatCode  
      AND AudTarget = 'DEP';  
  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT '';  
   PRINT CONVERT(VARCHAR(6), @Cnt) + ' dependent records inserted into dbo.U_dsi_BDM_Audit_Future';  
   END  
  
END;  
  
  
-----------  
-- Clear or preserve previous runs  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Clear or preserve previous runs');  
  
IF @AddToPreviousRun <> 'Y' BEGIN  
  
   -- Clear the previous run and the dbo.U_dsi_BDM_Runs table  
   /*  
   IF @EmpFlag = 'Y' BEGIN  
      DELETE FROM dbo.U_dsi_BDM_EmpDeductions WHERE EedFormatCode = @FormatCode  
   END  
  
   IF @DepFlag = 'Y' BEGIN  
      DELETE FROM dbo.U_dsi_BDM_DepDeductions WHERE DbnFormatCode = @FormatCode  
   END  
   */  
     
   DELETE FROM dbo.U_dsi_BDM_EmpDeductions WHERE EedFormatCode = @FormatCode;  
   DELETE FROM dbo.U_dsi_BDM_DepDeductions WHERE DbnFormatCode = @FormatCode;  
  
   DELETE FROM dbo.U_dsi_BDM_Runs WHERE FormatCode = @FormatCode;  
  
END; ELSE BEGIN  
  
   -- Preserve the previous run, unless there have been four or more  
  
   SELECT @Cnt = COUNT(1) FROM dbo.U_dsi_BDM_Runs WHERE FormatCode = @FormatCode  
   IF @Cnt >= 4 BEGIN  
      RAISERROR ('Four or more previous runs found; BDM can only process four runs per session.', 11, 1);  
      RETURN;  
   END;  
  
   INSERT INTO dbo.U_dsi_BDM_Runs VALUES (@FormatCode);  
   SET @TempFormatCode = RIGHT(RTRIM(dbo.fn_GetTimedKey()), 10);  
  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT 'Setting previous run''s formatcode to ' + @TempFormatCode;  
   END;  
  
   IF @EmpFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions SET EedFormatCode = @TempFormatCode WHERE EedFormatCode = @FormatCode;  
   END;  
  
   IF @DepFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions SET DbnFormatCode = @TempFormatCode WHERE DbnFormatCode = @FormatCode;  
   END;  
  
END;  
  
  
-----------  
-- Populate employee deductions with records containing that deduction in dbo.EmpDed or dbo.LodEDed  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Populate employee deductions with records containing that deduction in dbo.EmpDed or dbo.LodEDed');  
  
IF @EmpFlag = 'Y' BEGIN  
   EXEC dbo.dsi_BDM_sp_InsertDedRows @FormatCode, 'EMP', @OEType, @OEPlatform, @StartDateTime;  
END;  
  
  
-----------  
-- Populate dependent deductions with records containing that deduction in dbo.DepBPlan or dbo.LodDdBpn  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Populate dependent deductions with records containing that deduction in dbo.DepBPlan or dbo.LodDdBpn');  
  
IF @DepFlag = 'Y' BEGIN  
   EXEC dbo.dsi_BDM_sp_InsertDedRows @FormatCode, 'DEP', @OEType, @OEPlatform, @StartDateTime;  
END;  
  
  
-----------  
-- Clear deduction tables if test EEIDs are being used  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Clear deduction tables if test EEIDs are being used');  
  
IF @TestEEIDCnt > 0 BEGIN  
  
   DELETE FROM dbo.U_dsi_BDM_EmpDeductions  
    WHERE EedFormatCode = @FormatCode  
      AND EedEEID NOT IN (SELECT ParmValue FROM dbo.U_dsi_BDM_Configuration  
                           WHERE FormatCode = @FormatCode  
                             AND ParmName = 'TestEEID');  
  
   DELETE FROM dbo.U_dsi_BDM_DepDeductions  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnEEID NOT IN (SELECT ParmValue FROM dbo.U_dsi_BDM_Configuration  
                           WHERE FormatCode = @FormatCode  
                             AND ParmName = 'TestEEID');  
  
END;  
  
  
-----------  
-- Set the Run ID, if necessary  
-----------  
  
IF @RunID <> '' AND @EmpFlag = 'Y' BEGIN  
   UPDATE dbo.U_dsi_BDM_EmpDeductions SET EedRunID = @RunID WHERE EedFormatCode = @FormatCode;  
END;  
  
IF @RunID <> '' AND @DepFlag = 'Y' BEGIN  
   UPDATE dbo.U_dsi_BDM_DepDeductions SET DbnRunID = @RunID WHERE DbnFormatCode = @FormatCode;  
END;  
  
  
-----------  
-- If UseDedStopDate is set to Y OR if DedIsBenefit <> 'Y', copy the EedStopDate into the EedBenStopDate field  
-----------  
  
-- The module can calculate terms using EedBenStopDate (which is the default)  
-- or the EedStopDate. To avoid writing a lot of redundant code, if the module  
-- is using EedStopDate then we temporarily copy the EedStopDate into the EedBenStopDate,  
-- let it process, and then copy it back at the end.  
  
--IF @UseDedStopDate = 'Y' BEGIN  
  
   -- Preserve the EedBenStartDate and EedBenStopDate  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedUSGDate1 = EedBenStartDate,  
          EedUSGDate2 = EedBenStopDate  
    WHERE EedFormatCode = @FormatCode  
    AND ((@UseDedStopDate = 'Y') OR (@UseDedStopDate <> 'Y' AND isnull(DedIsBenefit,'') <> 'Y'));  
  
  
   -- Copy the EedStartDate/EedStopDate into EedBenStartDate/EedBenStopDate  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedBenStartDate = EedStartDate,  
          EedBenStopDate = EedStopDate  
    WHERE EedFormatCode = @FormatCode  
    AND ((@UseDedStopDate = 'Y') OR (@UseDedStopDate <> 'Y' AND isnull(DedIsBenefit,'') <> 'Y'));  
  
--END  
  
  
-----------  
-- If TermsOnly is set to Y, invalidate all active deductions  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'If TermsOnly is set to Y, invalidate all active deductions');  
  
IF @TermsOnly = 'Y' AND @EmpFlag = 'Y' BEGIN  
  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedValidForExport = 'N',  
             EedDedRowStatus   = 'Active deduction; export set to terms only'  
       WHERE EedFormatCode = @FormatCode  
         AND EedBenStopDate IS NULL;  
  
END;  
  
IF @TermsOnly = 'Y' AND @DepFlag = 'Y' BEGIN  
  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'N',  
             DbnDedRowStatus   = 'Active deduction; export set to terms only'  
       WHERE DbnFormatCode = @FormatCode  
         AND DbnBenStopDate IS NULL;  
  
END;  
  
  
-----------  
-- If it's an OE run (active or passive) and the @IncludeOEDrops option is set to N, invalidate all termed coverage  
  
-- If it's an OE run (active or passive) and @IncludeOEDrops is set to N, Allow active coverage to be included for  
-- Terminated employees when OERemoveTermEmps = 'N'  
-----------  
  
IF @OEType <> '' AND @IncludeOEDrops = 'N' BEGIN  
  
   IF @EmpFlag = 'Y' BEGIN  
  
      -- Termed employees  
  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedValidForExport = 'N',  
             EedDedRowStatus   = 'EE is termed; OE terms are set to drop'  
        FROM dbo.U_dsi_BDM_EmpDeductions  
        JOIN dbo.EmpComp WITH (NOLOCK) ON EecCOID = EedCOID AND EecEEID = EedEEID AND EecEmplStatus = 'T'  
       WHERE EedFormatCode = @FormatCode  
      AND @OERemoveTermEmps<>'N';  
  
  
      -- Termed deductions (EE may still be active)  
  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedValidForExport = 'N',  
             EedDedRowStatus   = 'EE deduction is termed; OE terms are set to drop'  
        FROM dbo.U_dsi_BDM_EmpDeductions  
       WHERE EedFormatCode = @FormatCode  
         AND NULLIF(EedBenStopDate, '01/01/1900') IS NOT NULL;  
  
   END;  
  
  
   IF @DepFlag = 'Y' BEGIN  
  
      -- Termed employees (EE will be invalid in dbo.U_dsi_BDM_EmpDeductions)  
  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'N',  
             DbnDedRowStatus   = 'EE is termed; OE terms are set to drop'  
        FROM dbo.U_dsi_BDM_DepDeductions  
        JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) ON  EedEEID = DbnEEID and EedDedCode = DbnDedCode  
       WHERE DbnFormatCode = @FormatCode and EedFormatCode = @FormatCode and EedValidForExport = 'N'  
             AND Not Exists   
             (Select 1 From dbo.U_dsi_BDM_EmpDeductions a Where a.EedEEID = DbnEEID and a.EedFormatCode = @FormatCode and a.EedDedcode = DbnDedCode and a.EedValidForExport = 'Y');  
              -- NWetherbee - V1.21 - Could have multiple codes because exist in multiple companies  
                
  
      -- Termed deductions (EE may still be active)  
  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'N',  
             DbnDedRowStatus   = 'Dep deduction is termed; OE terms are set to drop'  
        FROM dbo.U_dsi_BDM_DepDeductions  
       WHERE DbnFormatCode = @FormatCode  
         AND NULLIF(DbnBenStopDate, '01/01/1900') IS NOT NULL;  
  
   END;  
END;  
  
  
-----------  
-- Invalidate waived deductions  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Invalidate waived deductions');  
  
-- (C)ancelled deductions are processed as terms  
  
IF @EmpFlag = 'Y' BEGIN  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedValidForExport = 'N',  
          EedDedRowStatus   = 'Deduction waived'  
    WHERE EedFormatCode = @FormatCode  
      AND EedBenStatus = 'W'  
      AND EedValidForExport = 'Y';  
END;  
  
IF @DepFlag = 'Y' BEGIN  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnValidForExport = 'N',  
          DbnDedRowStatus   = 'Deduction waived'  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnBenStatus = 'W'  
      AND DbnValidForExport = 'Y';  
END;  
  
  
-----------  
-- Invalidate deductions where start date = end date  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Invalidate deductions where start date = end date')  
  
IF @EmpFlag = 'Y' BEGIN  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedValidForExport = 'N',  
          EedDedRowStatus   = 'Deduction start date = end date'  
    WHERE EedFormatCode = @FormatCode  
      AND COALESCE(EedBenStartDate, '01/01/1900') = COALESCE(EedBenStopDate, '01/01/1900')  
      AND EedValidForExport = 'Y';  
END;  
  
IF @DepFlag = 'Y' BEGIN  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnValidForExport = 'N',  
          DbnDedRowStatus   = 'Deduction start date = end date'  
    WHERE DbnFormatCode = @FormatCode  
      AND COALESCE(DbnBenStartDate, '01/01/1900') = COALESCE(DbnBenStopDate, '01/01/1900')  
      AND DbnValidForExport = 'Y';  
END;  
  
  
  
-----------  
-- Set 1/1/1900 stop dates to NULL  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Set 1/1/1900 stop dates to NULL');  
  
IF @EmpFlag = 'Y' BEGIN  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedBenStopDate = NULL WHERE EedFormatCode = @FormatCode AND EedBenStopDate = '1/1/1900';  
END;  
  
IF @DepFlag = 'Y' BEGIN  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnBenStopDate = NULL WHERE DbnFormatCode = @FormatCode AND DbnBenStopDate = '1/1/1900';  
END;  
  
  
-----------  
-- Invalidate dependent deductions where there is a data issue  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Invalidate dependent deductions where there is a data issue');  
  
IF @DepFlag = 'Y' AND @InvalidateBadDeps = 'Y' BEGIN  
  
    
  -- Dependent has a valid deduction but employee's deduction doesn't exist or is Termed  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnValidForExport = 'N',  
          DbnDedRowStatus   = 'Data issue: dependent has deduction but employee''s deduction doesn''t exist'  
    FROM dbo.U_dsi_BDM_DepDeductions  
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) ON EedFormatCode = DbnFormatCode AND EedEEID = DbnEEID AND EedDedCode = DbnDedCode  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnValidForExport = 'Y'  
      AND EedEEID is null;  
  
  
   -- Dependent has a valid active deduction but employee's deduction is termed  
  
  UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnValidForExport = 'N',  
          DbnDedRowStatus   = 'Data issue: dependent has active deduction but employee''s deduction is termed'  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnValidForExport = 'Y'  
   AND DbnBenStopDate is Null  
      AND NOT EXISTS (Select 1  
       From dbo.U_dsi_BDM_EmpDeductions  
       Where EedFormatCode = DbnFormatCode AND EedEEID = DbnEEID AND EedDedCode = DbnDedCode  
       and EedValidForExport = 'Y' and EedBenStopDate is Null);  
  
  
  
  
END;  
  
  
-----------  
-- Ensure employee deductions were populated before continuing  
-----------  
  
IF @EmpFlag = 'Y' BEGIN  
   SET @Cnt = 0;  
   SELECT @Cnt = COUNT(1) FROM dbo.U_dsi_BDM_EmpDeductions WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y';  
   IF @Cnt = 0 BEGIN  
      PRINT '>>>';  
      PRINT '>>>';  
      PRINT '>>> WARNING: no employee deductions created';  
      PRINT '>>>';  
      PRINT '>>>';  
   END;  
END;  
  
  
-----------  
-- Invalidate deductions where an earlier deduction of the same type exists, if necessary.  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Invalidate deductions where an earlier deduction of the same type exists, if necessary');  
  
-- Previous deductions are invalidated if:  
-- 1> The current deduction is in the export's deduction list.  
-- 2> The current deduction is active and the previous deduction is termed.  
-- 3> The current deduction has a start date greater than the previous deduction's start date  
  
-- Show only employee's latest rows for all companies.  
  
IF @EmpFlag = 'Y' AND @TermSelectionOption <> 'ActiveOnly' AND @AllowMultiDedType <> 'Y' BEGIN  
  
  -- Invalidate any termed deductions where there is an active deduction of the same type  
  
   ;WITH TempSelectTable AS (  
  
      SELECT  
  
      EedEEID              TmpEEID,  
      DedDedType           TmpDedType  
  
      FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)  
      WHERE EedFormatCode = @FormatCode  
        AND EedBenStopDate IS NULL  
        AND EedValidForExport = 'Y'  
   )  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedValidForExport = 'N',  
          EedDedRowStatus   = 'Deduction is termed, active deduction exists'  
     FROM TempSelectTable  
    WHERE EedFormatCode = @FormatCode  
      AND EedEEID = TmpEEID  
      AND DedDedType = TmpDedType  
      AND EedBenStopDate IS NOT NULL  
      AND EedValidForExport = 'Y';  
  
  
  -- Invalidate any termed deduction where a termed deduction of the same type exists with a later term date  
  
     
 ;WITH TempSelectTable AS (  
      SELECT  
      EedEEID              TmpEEID,  
      DedDedType           TmpDedType,  
      MAX( rtrim(convert(varchar(8),EedBenStopDate,112)+rtrim(convert(varchar(10),EedEmpDedTVID))) )  TmpBenStopID  
  
      FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)  
      WHERE EedFormatCode = @FormatCode  
        AND EedBenStopDate IS NOT NULL  
        AND EedValidForExport = 'Y'  
      GROUP BY EedEEID, DedDedType  
   )  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedValidForExport = 'N',  
          EedDedRowStatus   = 'Deduction is termed but another deduction exists with a later term date'  
     FROM TempSelectTable  
    WHERE EedFormatCode = @FormatCode  
      AND EedEEID = TmpEEID  
      AND DedDedType = TmpDedType  
      AND EedBenStopDate IS NOT NULL  
      AND EedBenStopDate <= Convert(DateTime,Left(TmpBenStopID,8))  
   AND EedEmpDedTVID <> Convert(int,substring(TmpBenStopID,9,len(TmpBenStopID)-8))  
      AND EedValidForExport = 'Y';  
  
END;  
  
  
-- Show only dependent's latest rows  
  
IF @DepFlag = 'Y' AND @TermSelectionOption <> 'ActiveOnly' AND @AllowMultiDedType <> 'Y' BEGIN  
  
   ;WITH TempSelectTable AS (  
  
      SELECT  
  
      DbnEEID              TmpEEID,  
      DbnDepRecID          TmpDepRecID,  
      DedDedType           TmpDedType  
  
      FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)  
      WHERE DbnFormatCode = @FormatCode  
        AND DbnBenStopDate IS NULL  
        AND DbnValidForExport = 'Y'  
   )  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnValidForExport = 'N',  
          DbnDedRowStatus   = 'Deduction is termed, active deduction exists'  
     FROM TempSelectTable  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnEEID = TmpEEID  
      AND DbnDepRecID = TmpDepRecID  
      AND DedDedType = TmpDedType  
      AND DbnBenStopDate IS NOT NULL  
      AND DbnValidForExport = 'Y';  
  
  
  -- Invalidate any termed deduction where a termed deduction of the same type exists with an earlier term date  
     
  
 ;WITH TempSelectTable AS (  
      SELECT  
      DbnEEID              TmpEEID,  
      DbnDepRecID          TmpDepRecID,  
      DedDedType           TmpDedType,  
      MAX( rtrim(convert(varchar(8),DbnBenStopDate,112)+rtrim(convert(varchar(10),DbnDepBPlanTVID))) )  TmpBenStopID  
  
      FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)  
      WHERE DbnFormatCode = @FormatCode  
        AND DbnBenStopDate IS NOT NULL  
        AND DbnValidForExport = 'Y'  
      GROUP BY DbnEEID, DbnDepRecID, DedDedType  
   )  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnValidForExport = 'N',  
          DbnDedRowStatus   = 'Deduction is termed but another deduction exists with a later term date'  
     FROM TempSelectTable  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnEEID = TmpEEID  
      AND DbnDepRecID = TmpDepRecID  
      AND DedDedType = TmpDedType  
      AND DbnBenStopDate IS NOT NULL  
      AND DbnBenStopDate <= Convert(DateTime,Left(TmpBenStopID,8))  
   AND DbnDepBPlanTVID <> Convert(int,substring(TmpBenStopID,9,len(TmpBenStopID)-8))  
      AND DbnValidForExport = 'Y';  
  
  
END;  
  
  
-----------  
-- Invalidate domestic partner deduction where a regular deduction exists  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Invalidate domestic partner deduction where a regular deduction exists');  
  
IF @EmpFlag = 'Y' AND @DedCodesDP <> '' AND @DiscardNonDPDeduction <> 'Y' BEGIN  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedValidForExport = 'N',  
          EedDedRowStatus   = 'DP deduction discarded because regular deduction exists'  
     FROM dbo.U_dsi_BDM_EmpDeductions a  
     JOIN dbo.U_dsi_BDM_DeductionCodes WITH (NOLOCK) ON UdcFormatCode = a.EedFormatCode AND UdcDedTarget = 'EMP' AND UdcDedCode = a.EedDedCode AND UdcIsDomPartnerDed = 'Y'  
    WHERE a.EedFormatCode = @FormatCode  
      AND a.EedValidForExport = 'Y'  
      AND EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions b  
                    JOIN dbo.U_dsi_BDM_DeductionCodes WITH (NOLOCK) ON UdcFormatCode = b.EedFormatCode AND UdcDedTarget = 'EMP' AND UdcDedCode = b.EedDedCode AND UdcIsDomPartnerDed = 'N'  
                   WHERE b.EedFormatCode = a.EedFormatCode  
                     AND b.EedCOID = a.EedCOID  
                     AND b.EedEEID = a.EedEEID  
                     AND b.EedValidForExport = 'Y');  
  
END;  
  
IF @DepFlag = 'Y' AND @DedCodesDP <> '' AND @DiscardNonDPDeduction <> 'Y' BEGIN  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnValidForExport = 'N',  
          DbnDedRowStatus   = 'DP deduction discarded because regular deduction exists'  
     FROM dbo.U_dsi_BDM_DepDeductions a  
     JOIN dbo.U_dsi_BDM_DeductionCodes WITH (NOLOCK) ON UdcFormatCode = a.DbnFormatCode AND UdcDedTarget = 'DEP' AND UdcDedCode = a.DbnDedCode AND UdcIsDomPartnerDed = 'Y'  
    WHERE a.DbnFormatCode = @FormatCode  
      AND a.DbnValidForExport = 'Y'  
      AND EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_DepDeductions b  
                    JOIN dbo.U_dsi_BDM_DeductionCodes WITH (NOLOCK) ON UdcFormatCode = b.DbnFormatCode AND UdcDedTarget = 'DEP' AND UdcDedCode = b.DbnDedCode AND UdcIsDomPartnerDed = 'N'  
                   WHERE b.DbnFormatCode = a.DbnFormatCode  
                     AND b.DbnEEID       = a.DbnEEID  
                     AND b.DbnDepRecID   = a.DbnDepRecID  
                     AND b.DbnValidForExport = 'Y');  
  
END;  
  
  
-----------  
-- Invalidate regular deduction where a domestic partner deduction exists  
-----------  
  
IF @EmpFlag = 'Y' AND @DedCodesDP <> '' AND @DiscardNonDPDeduction = 'Y' BEGIN  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedValidForExport = 'N',  
          EedDedRowStatus   = 'Regular deduction discarded because a DP deduction exists'  
     FROM dbo.U_dsi_BDM_EmpDeductions a  
     JOIN dbo.U_dsi_BDM_DeductionCodes WITH (NOLOCK) ON UdcFormatCode = a.EedFormatCode AND UdcDedTarget = 'EMP' AND UdcDedCode = a.EedDedCode AND UdcIsDomPartnerDed = 'N'  
    WHERE a.EedFormatCode = @FormatCode  
      AND a.EedValidForExport = 'Y'  
      AND EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions b WITH (NOLOCK)  
                    JOIN dbo.U_dsi_BDM_DeductionCodes WITH (NOLOCK) ON UdcFormatCode = b.EedFormatCode AND UdcDedTarget = 'EMP' AND UdcDedCode = b.EedDedCode AND UdcIsDomPartnerDed = 'Y'  
                   WHERE b.EedFormatCode = a.EedFormatCode  
                     AND b.EedCOID = a.EedCOID  
                     AND b.EedEEID = a.EedEEID  
                     AND b.EedValidForExport = 'Y');  
  
END;  
  
IF @DepFlag = 'Y' AND @DedCodesDP <> '' AND @DiscardNonDPDeduction = 'Y' BEGIN  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnValidForExport = 'N',  
          DbnDedRowStatus   = 'Regular deduction discarded because a DP deduction exists'  
     FROM dbo.U_dsi_BDM_DepDeductions a  
     JOIN dbo.U_dsi_BDM_DeductionCodes WITH (NOLOCK) ON UdcFormatCode = a.DbnFormatCode AND UdcDedTarget = 'DEP' AND UdcDedCode = a.DbnDedCode AND UdcIsDomPartnerDed = 'N'  
    WHERE a.DbnFormatCode = @FormatCode  
      AND a.DbnValidForExport = 'Y'  
      AND EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_DepDeductions b WITH (NOLOCK)  
                    JOIN dbo.U_dsi_BDM_DeductionCodes WITH (NOLOCK) ON UdcFormatCode = b.DbnFormatCode AND UdcDedTarget = 'DEP' AND UdcDedCode = b.DbnDedCode AND UdcIsDomPartnerDed = 'Y'  
                   WHERE b.DbnFormatCode = a.DbnFormatCode  
                     AND b.DbnEEID       = a.DbnEEID  
                     AND b.DbnDepRecID   = a.DbnDepRecID  
                     AND b.DbnValidForExport = 'Y');  
  
END;  
  
  
-----------  
-- If @ExclFutureDatedStopDates is Y, null out all future stop dates. The EE would still be considered active.  
-----------  
  
IF @ExclFutureDatedStopDates = 'Y' BEGIN  
  
   IF @EmpFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedBenStopDate = NULL  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'Y'  
         AND EedBenStopDate IS NOT NULL  
         AND EedBenStopDate > @EndDateTime;  
   END;  
  
   IF @DepFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnBenStopDate = NULL  
       WHERE DbnFormatCode = @FormatCode  
         AND DbnValidForExport = 'Y'  
         AND DbnBenStopDate IS NOT NULL  
         AND DbnBenStopDate > @EndDateTime;  
   END;  
  
END;  
  
  
-----------  
-- If a limit is set on future-dated stop dates, null out all stop dates past the limit.  
-----------  
  
IF @FutureStopDateLimit IS NOT NULL BEGIN  
  
   IF @EmpFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedBenStopDate = NULL  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'Y'  
         AND EedBenStopDate IS NOT NULL  
         AND EedBenStopDate > @FutureStopDateLimit;  
   END;  
  
   IF @DepFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnBenStopDate = NULL  
       WHERE DbnFormatCode = @FormatCode  
         AND DbnValidForExport = 'Y'  
         AND DbnBenStopDate IS NOT NULL  
         AND DbnBenStopDate > @FutureStopDateLimit;  
   END;  
  
END;  
  
  
-----------  
-- Null out any stop dates where the audit entry for the stop date exists only in the future  
-----------  
  
-- If the record is termed but the stop date audit entry exists only in the future, the employee  
-- is considered active and the benefit stop dates are nulled out. For example, on Monday at noon  
-- the client runs the export for the previous week, Saturday to Friday. If a term was entered earlier that Monday  
-- it shouldn't appear as a term because it wasn't entered within the date range. In that case, the stop  
-- date is nulled and the employee appears as active. On the next export the employee will appear as a term.  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Null out any stop dates where the audit entry for the stop date exists only in the future');  
  
IF @EmpFlag = 'Y' AND @TermSelectionOption = 'AuditDate' BEGIN  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedBenStopDate = NULL  
     FROM dbo.U_dsi_BDM_EmpDeductions  
     JOIN dbo.U_dsi_BDM_Audit_Future f WITH (NOLOCK) ON f.AudFormatCode = @FormatCode AND f.AudKey1Value = EedEEID AND f.AudKey2Value = EedCOID AND f.AudKey3Value = EedDedCode AND f.AudFieldName = @EEStopDateField  
     LEFT JOIN dbo.U_dsi_BDM_Audit c WITH (NOLOCK) ON c.AudFormatCode = @FormatCode AND c.AudKey1Value = EedEEID AND c.AudKey2Value = EedCOID AND c.AudKey3Value = EedDedCode AND c.AudFieldName = @EEStopDateField  
    WHERE EedFormatCode = @FormatCode  
      AND EedBenStopDate IS NOT NULL  
      AND c.AudFormatCode IS NULL;  
END;  
  
IF @DepFlag = 'Y' AND @TermSelectionOption = 'AuditDate' BEGIN  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnBenStopDate = NULL  
     FROM dbo.U_dsi_BDM_DepDeductions  
     JOIN dbo.U_dsi_BDM_Audit_Future f WITH (NOLOCK) ON f.AudFormatCode = @FormatCode AND f.AudKey1Value = DbnEEID AND f.AudKey2Value = DbnDedCode AND f.AudKey3Value = DbnSystemID AND f.AudFieldName = 'DbnBenStopDate'  
     LEFT JOIN dbo.U_dsi_BDM_Audit c WITH (NOLOCK) ON c.AudFormatCode = @FormatCode AND c.AudKey1Value = DbnEEID AND c.AudKey2Value = DbnDedCode AND c.AudKey3Value = DbnSystemID AND c.AudFieldName = 'DbnBenStopDate'  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnBenStopDate IS NOT NULL  
      AND c.AudFormatCode IS NULL;  
END;  
  
  
-----------  
-- Invalidate any remaining termed deductions - they will be re-validated below if they're valid for this run  
-----------  
  
-- Sets to T because we don't want to consider any previously invalidated deductions  
  
UPDATE dbo.U_dsi_BDM_EmpDeductions  
   SET EedValidForExport = 'T',  
       EedDedRowStatus   = 'Deduction termed before date range'  
 WHERE EedFormatCode = @FormatCode  
   AND EedValidForExport = 'Y'  
   AND EedBenStopDate IS NOT NULL;  
  
UPDATE dbo.U_dsi_BDM_DepDeductions  
   SET DbnValidForExport = 'T',  
       DbnDedRowStatus   = 'Deduction termed before date range'  
 WHERE DbnFormatCode = @FormatCode  
   AND DbnValidForExport = 'Y'  
   AND DbnBenStopDate IS NOT NULL;  
  
  
-----------  
-- Term selection option 1: benefit stop date falls within the date range  
-----------  
  
-- We're only dropping EEs/Deps that have a stop date before the date range. Records that  
-- have a stop date within the range are included; records with a stop date after the range  
-- would still be active. If the @ExclFutureDatedStopDates parm is set to False, the term  
-- date for the future-dated terms will be blanked but the record will still be on the export.  
  
IF @TermSelectionOption = 'StopDate' BEGIN  
  
   INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Term selection option 1: benefit stop date falls within the date range');  
  
   IF @EmpFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedValidForExport = 'Y',  
             EedDedRowStatus   = 'Deduction termed within/after date range'  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'T'  
         AND EedBenStopDate IS NOT NULL  
         AND EedBenStopDate >= @StartDateTime;  
   END;  
  
   IF @DepFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'Y',  
             DbnDedRowStatus   = 'Deduction termed within/after date range'  
       WHERE DbnFormatCode = @FormatCode  
         AND DbnValidForExport = 'T'  
         AND DbnBenStopDate IS NOT NULL  
         AND DbnBenStopDate >= @StartDateTime;  
   END;  
  
END;  
  
  
-----------  
-- Term selection option 2: Date benefit stop date is keyed into audit falls within the date range  
-----------  
  
IF @TermSelectionOption = 'AuditDate' BEGIN  
  
   INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Term selection option 2: Date benefit stop date is keyed into audit falls within the date range');  
  
   IF @EmpFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedValidForExport = 'Y',  
             EedDedRowStatus   = 'Deduction stop date audit entry or EffDate within date range'  
         FROM dbo.U_dsi_BDM_EmpDeductions  
         JOIN dbo.U_dsi_BDM_Audit WITH (NOLOCK) ON AudFormatCode = @FormatCode AND AudKey1Value = EedEEID AND AudKey2Value = EedCOID AND AudKey3Value = EedDedCode AND AudFieldName in ('eedBenStopDate','eedStopDate')  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'T'  
         AND EedBenStopDate IS NOT NULL;  
   END;  
  
  
   IF @DepFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'Y',  
             DbnDedRowStatus   = 'Deduction stop date audit entry or EffDate within date range'  
        FROM dbo.U_dsi_BDM_DepDeductions  
        JOIN dbo.U_dsi_BDM_Audit WITH (NOLOCK) ON AudFormatCode = @FormatCode AND AudKey1Value = DbnEEID AND AudKey2Value = DbnDedCode AND AudKey3Value = DbnSystemID AND AudFieldName = 'DbnBenStopDate'  
       WHERE DbnFormatCode = @FormatCode  
         AND DbnValidForExport = 'T'  
         AND DbnBenStopDate IS NOT NULL;  
   END;  
  
/*  
-- NWetherbee - 09/17/2012 - Code deemed not necessary after eff-date was added to dbo.vw_AuditData view and  
--                           used in earlier step to select deds for audit tables.  
  
   IF @EmpFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedValidForExport = 'Y',  
             EedDedRowStatus   = 'Deduction stop date is populated and effective date is within date range'  
        FROM dbo.U_dsi_BDM_EmpDeductions  
        JOIN dbo.vw_AuditData WITH (NOLOCK) ON AudUniqueKey = EedEmpDedTVID AND AudTableName = 'EmpDed' AND AudFieldName = @EEStopDateField  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'T'  
         AND EedBenStopDate IS NOT NULL  
         AND EedTVStartDate BETWEEN @StartDateTime AND @EndDateTime  
   END  
  
  
   IF @DepFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'Y',  
             DbnDedRowStatus   = 'Deduction stop date is populated and effective date is within date range'  
        FROM dbo.U_dsi_BDM_DepDeductions  
        JOIN dbo.vw_AuditData WITH (NOLOCK) ON AudUniqueKey = DbnDepBPlanTVID AND AudTableName = 'DepBPlan' AND AudFieldName = 'DbnBenStopDate'  
      WHERE DbnFormatCode = @FormatCode  
         AND DbnValidForExport = 'T'  
         AND DbnBenStopDate IS NOT NULL  
         AND DbnTVStartDate BETWEEN @StartDateTime AND @EndDateTime  
   END  
*/  
  
   -- If there is no audit entry but 1> the stop date is within the range and future stop dates are excluded, send  
   -- This stop was entered sometime in the past, but wasn't sent as a term then because future stop dates were excluded  
  
   IF @EmpFlag = 'Y' AND (@ExclFutureDatedStopDates = 'Y' OR @FutureStopDateLimit IS NOT NULL) BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedValidForExport = 'Y',  
             EedDedRowStatus   = 'Deduction stop was a future-dated date that is now within the date range'  
        FROM dbo.U_dsi_BDM_EmpDeductions  
        LEFT JOIN dbo.U_dsi_BDM_Audit c        WITH (NOLOCK) ON c.AudFormatCode = @FormatCode AND c.AudKey1Value = EedEEID AND c.AudKey2Value = EedCOID AND c.AudKey3Value = EedDedCode AND c.AudFieldName in ('eedBenStopDate','eedStopDate')  
        LEFT JOIN dbo.U_dsi_BDM_Audit_Future f WITH (NOLOCK) ON f.AudFormatCode = @FormatCode AND f.AudKey1Value = EedEEID AND f.AudKey2Value = EedCOID AND f.AudKey3Value = EedDedCode AND f.AudFieldName in ('eedBenStopDate','eedStopDate')  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'T'  
         AND EedBenStopDate IS NOT NULL  
         AND EedBenStopDate BETWEEN @StartDateTime AND @EndDateTime  
         AND c.AudKey1Value IS NULL  
    AND f.AudKey1Value IS NULL;  
   END;  
  
   IF @DepFlag = 'Y' AND (@ExclFutureDatedStopDates = 'Y' OR @FutureStopDateLimit IS NOT NULL) BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'Y',  
             DbnDedRowStatus   = 'Deduction stop was a future-dated date that is now within the date range'  
        FROM dbo.U_dsi_BDM_DepDeductions  
        LEFT JOIN dbo.U_dsi_BDM_Audit c        WITH (NOLOCK) ON c.AudFormatCode = @FormatCode AND c.AudKey1Value = DbnEEID AND c.AudKey2Value = DbnDedCode AND c.AudKey3Value = DbnSystemID AND c.AudFieldName = 'DbnBenStopDate'  
        LEFT JOIN dbo.U_dsi_BDM_Audit_Future f WITH (NOLOCK) ON f.AudFormatCode = @FormatCode AND f.AudKey1Value = DbnEEID AND f.AudKey2Value = DbnDedCode AND f.AudKey3Value = DbnSystemID AND f.AudFieldName = 'DbnBenStopDate'  
      WHERE DbnFormatCode = @FormatCode  
         AND DbnValidForExport = 'T'  
         AND DbnBenStopDate IS NOT NULL  
         AND DbnBenStopDate BETWEEN @StartDateTime AND @EndDateTime  
         AND c.AudKey1Value IS NULL  
         AND f.AudKey1Value IS NULL;  
   END;  
  
END;  
  
  
-----------  
-- Term selection option 3: actives only  
-----------  
  
-- Terms were already invalidated above, so no action is necessary  
  
  
-----------  
-- Reset remaining terms to invalid  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Reset remaining terms to invalid');  
  
UPDATE dbo.U_dsi_BDM_EmpDeductions  
   SET EedValidForExport = 'N',  
       EedDedRowStatus   = 'Deduction termed'  
 WHERE EedFormatCode = @FormatCode  
   AND EedValidForExport = 'T';  
  
UPDATE dbo.U_dsi_BDM_DepDeductions  
   SET DbnValidForExport = 'N',  
       DbnDedRowStatus   = 'Deduction termed'  
 WHERE DbnFormatCode = @FormatCode  
   AND DbnValidForExport = 'T';  
  
  
-----------  
-- If future-dated start dates are excluded, invalidate all records with future-dated start dates  
-----------  
  
IF @ExclFutureDatedStartDates = 'Y' BEGIN  
  
   IF @EmpFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedValidForExport = 'N',  
             EedDedRowStatus   = 'Deduction has a future-dated start date'  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'Y'  
         AND EedBenStartDate > @EndDateTime;  
   END;  
  
   IF @DepFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'N',  
             DbnDedRowStatus   = 'Deduction has a future-dated start date'  
       WHERE DbnFormatCode = @FormatCode  
         AND DbnValidForExport = 'Y'  
         AND DbnBenStartDate > @EndDateTime;  
   END;  
  
END;  
  
  
-----------  
-- If a limit is set on future-dated start dates, invalidate all records with future-dated start dates past the limit  
-----------  
  
IF @FutureStartDateLimit IS NOT NULL BEGIN  
  
   IF @EmpFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedValidForExport = 'N',  
             EedDedRowStatus   = 'Deduction has a future-dated start date'  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'Y'  
         AND EedBenStartDate > @FutureStartDateLimit;  
   END;  
  
   IF @DepFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'N',  
             DbnDedRowStatus   = 'Deduction has a future-dated start date'  
       WHERE DbnFormatCode = @FormatCode  
         AND DbnValidForExport = 'Y'  
         AND DbnBenStartDate > @FutureStartDateLimit;  
   END;  
  
END;  
  
  
-----------  
-- Invalidate Dependent records if they were marked as valid because they were recently stopped (via audit)  
-- but the employee's deduction has long since been stopped (not in recent audit snapshot).   
-----------  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
         SET DbnValidForExport = 'N',  
             DbnDedRowStatus   = 'Dep coverage recently stopped; Emp coverage previously stopped'  
        FROM dbo.U_dsi_BDM_DepDeductions  
        JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) ON  EedEEID = DbnEEID and EedCOID = DbnCOID and EedDedCode = DbnDedCode  
       WHERE DbnFormatCode = @FormatCode and EedFormatCode = @FormatCode  
             and EedValidForExport = 'N' and DbnValidForExport = 'Y'  
             and EedBenStopDate is Not Null and DbnBenStopDate is Not Null  
             and @DepFlag = 'Y';  
  
  
-----------  
-- Find the max effective entered record for each effective date  
  
--v1.26 (8/1/2016) Corrected insert into dbo.U_dsi_BDM_EmpHDed_max.  Partition by  EdhEffDate should not have been included in the Row_Number field.   
--As a result, the most recent Change Reason was not being properly identified.  
-----------  
  
If @GetChangeReason = 'Y' or @CalcBenOptionDate <> '' or @CobraType in ('2','3')  
BEGIN  
  
  DELETE FROM dbo.U_dsi_BDM_EmpHDed_max  
    WHERE EdhFormatCode = @FormatCode;  
  
INSERT INTO dbo.U_dsi_BDM_EmpHDed_max  
   SELECT  
  
   EedFormatCode,  
   EdhRowNum = ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode , EdhEffDate ORDER BY EdhEEID, edhcoid, EdhEffDate DESC, edhdatetimecreated desc),  
   EdhRowChangeRsn = ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEEID, edhcoid, EdhEffDate DESC, edhdatetimecreated desc),  
   EdhCOID,  
   EdhEEID,  
   EdhDedCode,  
   EdhEffDate,  
   EdhBenOption,  
   EdhChangeReason,  
   EdhSystemid  
  
   FROM dbo.U_dsi_BDM_EmpDeductions  
   JOIN dbo.EmpHDed ON EedCOID = EdhCOID AND EedEEID = EdhEEID AND EedDedCode = EdhDedCode  
   WHERE EedFormatCode = @Formatcode and EedValidForExport = 'Y'  
   ORDER BY EdhEEID, EdhDedCode, EdhEffDate DESC;  
  
-----------  
-- delete all records from above table where edhrownum does not equal 1  
-----------  
 Delete dbo.U_dsi_BDM_EmpHDed_max  
 where edhrownum <> 1;  
END;  
  
-- Find the max effective entered record for each effective date  
  
If @CobraType in ('4') --1.28  
BEGIN  
  
  DELETE FROM dbo.U_dsi_BDM_EmpHDed_max  
    WHERE EdhFormatCode = @FormatCode;  
  
INSERT INTO dbo.U_dsi_BDM_EmpHDed_max  
   SELECT  
  
   EedFormatCode,  
   EdhRowNum = ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode , EdhEffDate ORDER BY EdhEEID, edhcoid, EdhEffDate DESC, edhdatetimecreated desc),  
   EdhRowChangeRsn = ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEEID, edhcoid, EdhEffDate DESC, edhdatetimecreated desc),  
   EdhCOID,  
   EdhEEID,  
   EdhDedCode,  
   EdhEffDate,  
   EdhBenOption,  
   EdhChangeReason,  
   EdhSystemid  
  
   FROM dbo.U_dsi_BDM_EmpDeductions  
   JOIN dbo.EmpHDed ON EedCOID = EdhCOID AND EedEEID = EdhEEID AND EedDedCode = EdhDedCode  
   WHERE EedFormatCode = @Formatcode and EedValidForExport = 'Y'  
   ORDER BY EdhEEID, EdhDedCode, EdhEffDate DESC;  
  
END;  
  
-----------  
-- Populate the benefits change reason, if necessary  
-----------  
  
IF @EmpFlag = 'Y' and @GetChangeReason = 'Y' BEGIN  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedChangeReason = EdhChangeReason  
     FROM dbo.U_dsi_BDM_EmpDeductions  
  JOIN dbo.U_dsi_BDM_EmpHDed_max with (nolock) on EedFormatcode = EdhFormatcode and Eedeeid = edheeid and  
    Eedcoid = edhcoid and Eeddedcode = EdhDedcode and EdhRowChangeRsn = 1  
    WHERE EedFormatCode = @FormatCode  
      AND EedValidForExport = 'Y';  
  
END;  
  
  
-----------  
-- Calculate the benefit option date for employees and dependents, if necessary  
-----------  
  
-- Employees  
  
IF @EmpFlag = 'Y' AND @CalcBenOptionDate IN ('1', '2') BEGIN  
  
   -- Populate the dbo.U_dsi_BDM_EmpHDed table  
  
   DELETE FROM dbo.U_dsi_BDM_EmpHDed  
    WHERE EdhFormatCode = @FormatCode;  
  
   INSERT INTO dbo.U_dsi_BDM_EmpHDed  
   SELECT  
  
   EdhFormatCode,  
   EdhRowNum = ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhDedCode ORDER BY EdhEEID, EdhEffDate DESC),  
   EdhCOID,  
   EdhEEID,  
   EdhDedCode,  
   EdhEffDate,  
   EdhBenOption,  
   'N',  
   'N'  
  
   FROM dbo.U_dsi_BDM_EmpHDed_max  
   JOIN dbo.U_dsi_BDM_EmpDeductions ON EedCOID = EdhCOID AND EedEEID = EdhEEID AND EedDedCode = EdhDedCode AND EedFormatCode = EdhFormatcode  
   WHERE EedFormatCode = @FormatCode and edhchangereason <> 'TRO'  
   ORDER BY EdhEEID, EdhDedCode, EdhEffDate DESC;  
  
  
   -- Update change flags -- any time the option changed  
  
   UPDATE dbo.U_dsi_BDM_EmpHDed  
      SET EdhChangeFlag = 'Y'  
     FROM dbo.U_dsi_BDM_EmpHDed a  
    WHERE EdhFormatCode = @FormatCode  
 AND EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_EmpHDed b  
                   WHERE b.EdhFormatCode = a.EdhFormatCode  
                     AND b.EdhCOID = a.EdhCOID  
                     AND b.EdhEEID = a.EdhEEID  
                     AND b.EdhDedCode = a.EdhDedCode  
                     AND b.EdhBenOption <> a.EdhBenOption  
                     AND b.EdhRowNum = a.EdhRowNum + 1);  
  
  
   -- Update the maximum effective date the option changed  
  
   UPDATE dbo.U_dsi_BDM_EmpHDed  
      SET EdhMaxChangeFlag = 'Y'  
     FROM dbo.U_dsi_BDM_EmpHDed a  
    WHERE a.EdhFormatCode = @FormatCode  
      AND a.EdhChangeFlag = 'Y'  
      AND a.EdhEffDate = (SELECT MAX(b.EdhEffDate) FROM dbo.U_dsi_BDM_EmpHDed b  
                           WHERE b.EdhFormatCode = a.EdhFormatCode  
                             AND b.EdhCOID = a.EdhCOID  
                             AND b.EdhEEID = a.EdhEEID  
                             AND b.EdhDedCode = a.EdhDedCode  
                             AND b.EdhBenOption = a.EdhBenOption  
                             AND b.EdhChangeFlag = a.EdhChangeFlag );  
  
  
     -- Update the EedBenOptionDate with the EedBenStartDate... this is the default  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedBenOptionDate = EedBenStartDate  
    WHERE EedFormatCode = @FormatCode  
      AND EedValidForExport = 'Y';  
  
  
   -- If the option changed, update the EedBenOptionDate with the maximum change date  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedBenOptionDate = EdhEffDate  
     FROM dbo.U_dsi_BDM_EmpDeductions  
     JOIN dbo.U_dsi_BDM_EmpHDed a ON a.EdhFormatCode = EedFormatCode AND a.EdhCOID = EedCOID AND a.EdhEEID = EedEEID AND a.EdhDedCode = EedDedCode AND a.EdhBenOption = EedBenOption AND a.EdhChangeFLAG = 'Y'  
    WHERE EedFormatCode = @FormatCode  
      AND EedValidForExport = 'Y'  
      AND EdhMaxChangeFlag = 'Y'  
      AND EdhEffDate > EedBenStartDate; -- has to be greater than the start date  
  
END;  
  
  
-- Dependents  
  
-- Update the DbnBenOptionDate  
  
IF @DepFlag = 'Y' AND @CalcBenOptionDate = '2' BEGIN  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnBenOptionDate = EedBenOptionDate  
     FROM dbo.U_dsi_BDM_EmpDeductions  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnValidForExport = 'Y'  
      AND EedFormatCode = @FormatCode  
      AND EedValidForExport = 'Y'  
      AND EedEEID = DbnEEID  
      AND EedDedCode = DbnDedCode  
      AND EedBenOptionDate IS NOT NULL  
      AND EedBenOptionDate >= DbnBenStartDate --6/15/18 -- Updated: Was  EedBenOptionDate > DbnBenStartDate  
      AND EedBenOptionDate < COALESCE(DbnBenStopDate, '1/1/3000'); -- don't send an EedBenOptionDate > term date if dependent is termed  
  
END;  
  
  
-- Update the BenStartDates if OverrideBenStartDate is set to Y  
  
IF @EmpFlag = 'Y' AND @OverrideBenStartDate = 'Y' BEGIN  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedBenStartDate = EedBenOptionDate  
    WHERE EedFormatCode = @FormatCode  
      AND EedValidForExport = 'Y'  
      AND EedBenOptionDate IS NOT NULL  
      AND EedBenOptionDate > EedBenStartDate;  
  
END;  
  
  
IF @DepFlag = 'Y' AND @OverrideBenStartDate = 'Y' BEGIN  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnBenStartDate = DbnBenOptionDate  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnValidForExport = 'Y'  
      AND DbnBenOptionDate IS NOT NULL  
      AND DbnBenOptionDate > DbnBenStartDate;  
  
END;  
  
  
-----------  
-- Update dependent relationships and birthdates  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Update dependent relationships and birthdates');  
  
IF @DepFlag = 'Y' BEGIN  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnRelationship = ConRelationship,  
          DbnDateofBirth  = ConDateofBirth  
     FROM dbo.U_dsi_BDM_DepDeductions  
     JOIN dbo.Contacts WITH (NOLOCK) ON ConEEID = DbnEEID AND ConSystemID = DbnDepRecID  
    WHERE DbnFormatCode = @FormatCode;  
  
END;  
  
  
-----------  
-- Update dependent counts, if necessary  
-----------  
  
IF @DepFlag = 'Y' AND @CountDependents = 'Y' BEGIN  
  
   INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Update dependent counts, if necessary');  
  
   -- Spouses  
  
   IF @RelationshipsSpouse <> '' BEGIN  
  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedNumSpouses = dbo.dsi_BDM_fn_GetDependentCount(@FormatCode, EedEEID, EedDedCode, 'S', @RelationshipsSpouse)  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'Y';  
  
   END;  
  
  
   -- Children  
  
   IF @RelationshipsChild <> '' BEGIN  
  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedNumChildren = dbo.dsi_BDM_fn_GetDependentCount(@FormatCode, EedEEID, EedDedCode, 'C', @RelationshipsChild)  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'Y';  
  
   END;  
  
  
   -- Domestic partners  
  
   IF @RelationshipsDomPartner <> '' BEGIN  
  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedNumDomPartners = dbo.dsi_BDM_fn_GetDependentCount(@FormatCode, EedEEID, EedDedCode, 'D', @RelationshipsDomPartner)  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'Y';  
  
   END;  
  
  
   -- Domestic partner children  
  
   IF @RelationshipsDPChild <> '' BEGIN  
  
      UPDATE dbo.U_dsi_BDM_EmpDeductions  
         SET EedNumDPChildren = dbo.dsi_BDM_fn_GetDependentCount(@FormatCode, EedEEID, EedDedCode, 'P', @RelationshipsDPChild)  
       WHERE EedFormatCode = @FormatCode  
         AND EedValidForExport = 'Y';  
  
   END;  
  
END;  
  
  
-----------  
-- Update dependent COID and BenOption to match employee fields  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Update dependent COID and BenOption to match employee fields');  
  
IF @DepFlag = 'Y' BEGIN  
  
   -- Both valid for export  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnCOID = EedCOID,  
          DbnBenOption = EedBenOption  
     FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)  
     JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) ON EedFormatCode = DbnFormatCode AND EedEEID = DbnEEID AND EedDedCode = DbnDedCode AND EedValidForExport = 'Y'  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnValidForExport = 'Y';  
  
  
   -- Dependent valid, EE invalid (can happen legitimately w/ Cobra). Pull from dbo.U_dsi_BDM_EmpDeductions using EE's current COID  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnCOID = EedCOID,  
          DbnBenOption = EedBenOption  
     FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)  
     JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) ON EedFormatCode = DbnFormatCode AND EedCOID = dbo.dsi_BDM_fn_GetCurrentCOID(EedEEID) AND EedEEID = DbnEEID AND EedDedCode = DbnDedCode  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnValidForExport = 'Y'  
      AND COALESCE(DbnCOID, '') = '';  
  
  
   -- Try on any employee COID  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnCOID = EedCOID,  
          DbnBenOption = EedBenOption  
     FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)  
     JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) ON EedFormatCode = DbnFormatCode AND EedEEID = DbnEEID AND EedDedCode = DbnDedCode  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnValidForExport = 'Y'  
      AND COALESCE(DbnCOID, '') = '';  
  
  
   -- If nothing above worked, update DbnCOID using employee's current COID regardless of deduction records  
  
   UPDATE dbo.U_dsi_BDM_DepDeductions  
      SET DbnCOID = dbo.dsi_BDM_fn_GetCurrentCOID(DbnEEID)  
    WHERE DbnFormatCode = @FormatCode  
      AND DbnValidForExport = 'Y'  
      AND COALESCE(DbnCOID, '') = '';  
  
END;  
  
  
-----------  
-- If UseDedStopDate is set to Y OR if DedIsBenefit <> 'Y', restore the EedStopDate and EedBenStopDate fields  
-----------  
  
--IF @EmpFlag = 'Y' AND @UseDedStopDate = 'Y' BEGIN  
  
   -- Set the EedStartDate and EedStopDate  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedStartDate = EedBenStartDate,  
          EedStopDate = EedBenStopDate  
    WHERE EedFormatCode = @FormatCode  
    AND ((@UseDedStopDate = 'Y') OR (@UseDedStopDate <> 'Y' AND isnull(DedIsBenefit,'') <> 'Y'));  
  
  
   -- Restore the original EedBenStartDate and EedBenStopDate  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedBenStartDate = EedUSGDate1,  
          EedBenStopDate = EedUSGDate2  
    WHERE EedFormatCode = @FormatCode  
    AND ((@UseDedStopDate = 'Y') OR (@UseDedStopDate <> 'Y' AND isnull(DedIsBenefit,'') <> 'Y'));  
  
   UPDATE dbo.U_dsi_BDM_EmpDeductions  
      SET EedUSGDate1 = NULL,  
          EedUSGDate2 = NULL  
    WHERE EedFormatCode = @FormatCode  
    AND ((@UseDedStopDate = 'Y') OR (@UseDedStopDate <> 'Y' AND isnull(DedIsBenefit,'') <> 'Y'));  
  
--END  
  
  
-----------  
-- Execute Cobra module, if necessary  
-----------  
  
IF @CobraType <> '' BEGIN  
   IF (@CobraType = '4' OR @CobraDate = '3' OR  @EepCobraReasonPCF <> '' OR @ConCobraReasonPCF <> '' OR @EepDateOfCobraEventPCF <> '' OR  @ConDateOfCobraEventPCF <> '' OR @CobraReasonsDepPQB <> '')  
       EXEC dbo.dsi_BDM_sp_ProcessCobraDeductions_v2 @FormatCode;  
   ELSE  
       EXEC dbo.dsi_BDM_sp_ProcessCobraDeductions @FormatCode;  
END;  
  
  
-----------  
-- Execute new enrollee module, if necessary  
-----------  
  
IF @NewEnrolleeType <> '' BEGIN  
   EXEC dbo.dsi_BDM_sp_ProcessNewEnrolleeDeductions @FormatCode;  
END;  
  
  
-----------  
-- Print final counts  
-----------  
  
INSERT INTO dbo.U_dsi_BDM_Timings VALUES(@FormatCode, GETDATE(), 'Print final counts');  
  
IF @EmpFlag = 'Y' BEGIN  
   SET @Cnt = 0;  
   SELECT @Cnt = COUNT(1) FROM dbo.U_dsi_BDM_EmpDeductions WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y';  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT '';  
   PRINT CONVERT(VARCHAR(6), @Cnt) + ' valid employee deductions in dbo.U_dsi_BDM_EmpDeductions';  
   END;  
END;  
  
IF @DepFlag = 'Y' BEGIN  
   SET @Cnt = 0;  
   SELECT @Cnt = COUNT(1) FROM dbo.U_dsi_BDM_DepDeductions WHERE DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';  
   IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
   BEGIN  
   PRINT CONVERT(VARCHAR(6), @Cnt) + ' valid dependent deductions in dbo.U_dsi_BDM_DepDeductions';  
   END;  
END;  
  
-----------  
-- List invalidated deductions  
-----------  
  
DECLARE @tvInvalidDeductions TABLE (  
tvRowNum       INT IDENTITY(1, 1),  
tvDedRowType   VARCHAR(10),  
tvDedRowStatus CHAR(75),  
tvCount        VARCHAR(6)  
);  
  
INSERT INTO @tvInvalidDeductions  
SELECT 'Employee  ', LEFT(EedDedRowStatus, 75), COUNT(1) FROM dbo.U_dsi_BDM_EmpDeductions  
 WHERE EedFormatCode = @FormatCode  
   AND EedValidForExport = 'N'  
GROUP BY EedDedRowStatus;  
  
INSERT INTO @tvInvalidDeductions  
SELECT 'Dependent ', LEFT(DbnDedRowStatus, 75), COUNT(1) FROM dbo.U_dsi_BDM_DepDeductions  
 WHERE DbnFormatCode = @FormatCode  
   AND DbnValidForExport = 'N'  
GROUP BY DbnDedRowStatus;  
  
IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
BEGIN  
PRINT '';  
PRINT 'Type       Reason invalidated                                                          Count';  
PRINT '----       --------------------------------------------------------------------------- -----';  
  
SET @Cnt = 0;  
WHILE 1=1 BEGIN  
  
  SET @Cnt = @Cnt + 1;  
  
  SET @DedRowStatus = '';  
  SELECT @DedRowType   = tvDedRowType,  
         @DedRowStatus = tvDedRowStatus,  
         @Count        = tvCount  
    FROM @tvInvalidDeductions  
   WHERE tvRowNum = @Cnt;  
  
   IF COALESCE(@DedRowStatus, '') = '' BREAK;  
  
   PRINT @DedRowType + ' ' + @DedRowStatus  + ' ' + CONVERT(VARCHAR(6), @Count);  
  
END;  
  
PRINT '';  
END;  
  
  
-----------  
-- Reset formatcodes for previous runs  
-----------  
  
IF @AddToPreviousRun = 'Y' BEGIN  
  
   IF @EmpFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_EmpDeductions SET EedFormatCode = @FormatCode WHERE EedFormatCode = @TempFormatCode AND @TempFormatCode <> '';  
   END;  
  
   IF @DepFlag = 'Y' BEGIN  
      UPDATE dbo.U_dsi_BDM_DepDeductions SET DbnFormatCode = @FormatCode WHERE DbnFormatCode = @TempFormatCode AND @TempFormatCode <> '';  
   END;  
  
END;  
  
  
-----------  
-- Build consolidated table, if necessary  
-----------  
  
IF @BuildConsolidatedTable <> '' BEGIN  
   EXEC dbo.dsi_BDM_sp_BuildConsolidatedTable @FormatCode, @BuildConsolidatedTable;  
END;  
  
  
-----------  
-- Show elapsed time  
-----------  
  
SET @ElapsedTime = GETDATE() - @ModuleStartDateTime;  
  
IF @TestingFlag <> 'N' -- Suppress Print Statements to the console when 'Testing' flag in dbo.U_dsi_Configuration is set to 'N'  
BEGIN  
PRINT 'Elapsed Time';  
PRINT '------------';  
  
PRINT 'Days    = ' + CONVERT(VARCHAR(32), DATEDIFF(DAY, 0, @ElapsedTime));  
PRINT 'Hours   = ' + CONVERT(VARCHAR(32), DATEPART(HOUR, @ElapsedTime));  
PRINT 'Minutes = ' + CONVERT(VARCHAR(32), DATEPART(MINUTE, @ElapsedTime));  
PRINT 'Seconds = ' + RTRIM(CONVERT(VARCHAR(32), DATEPART(SECOND, @ElapsedTime))) + '.' + CONVERT(VARCHAR(32), DATEPART(MILLISECOND, @ElapsedTime));  
PRINT '';  
END;