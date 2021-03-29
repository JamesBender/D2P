/*
James Bender  10:30 AM
Hi, got a questions about Newport; do we have an example of a situation where a 302 event happened the dep should be showing up? 
The only one I found for this year was for Peter Van Zly’s dependent Traci who had her DENBA coverage termed on 1/1/2021, but I can’t find a cobra record in Ulti and she’s not coming over with a Cobra reason the BDM table.

Cheryl Petitti  10:51 AM
Try the info below
10:51
Mara Cubellis (dependent of John Cubellis – employee ID: 12319) (terminated, removed dependent 10/31/20)
10:52
You will have to use a date range that includes 10/31/20
10:52
I didn't think we were using the cobra reason any longer.  I thought we were using the benefit change reason
10:52
Do you want to look at this together
*/

DECLARE @EEID VARCHAR(12)

Select @EEID = 'CP4OJN000030';
--SELECT @EEID = 'DIWZDT000030'

--sp_getEEID 'Cubellis' -- CP4OJN000030, John

select * from dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
where BdmRunId = 'QB'
and BdmEEID = @EEID

--select * from dbo.U_dsi_BDM_EDSICCBEXP where BdmEEID = @EEID
select * from dbo.U_EDSICCBEXP_drvTbl_QB where drvEEID = @EEID
select * from dbo.U_EDSICCBEXP_drvTbl_QBDEPENDENT where drvEEID = @EEID

--sp_getEEID 'DIWZDT000030' -- Van Zyl, Peter

--select * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE EedEEID = @EEID and EedFormatCode = 'EDSICCBEXP'

--select * from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) WHERE DbnEEID = @EEID and DbnFormatCode = 'EDSICCBEXP'

--select top 10 * from EmpHDed where EdhChangeReason IN ('302') AND EdhBenStatusDate >= '1/1/2021' -- DIWZDT000030 -- DENBA