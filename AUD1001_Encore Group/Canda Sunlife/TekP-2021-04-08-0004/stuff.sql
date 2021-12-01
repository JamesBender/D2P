select * from dbo.U_ECANSUNEXP_drvTbl_PersonLink
select * from dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
where BdmRecType <> 'EMP'


/*select top 100 * from EmpDed where EedDedCode IN ('CEXSL','CDPL','COPLF','CADD','CXADD','CXADP','CSTD','CLTD','CDENT','CMED')
and EedBenStatus = 'A'
and EedDepRecID is not null*/


select distinct drvEEID  from dbo.U_ECANSUNEXP_drvTbl_Benefits
where drvEEID IN (
select eecEEID from EmpComp
where EecEEID iN (select distinct drvEEID  from dbo.U_ECANSUNEXP_drvTbl_Member) AND EecEmplStatus = 'T'
)


select eecEEID, EecEmplStatus, * from EmpComp where EecEEID IN ('84VPZ20000K0','84VR320000K0','858RBJ0000K0','858RBY0000K0','85N9B70000K0','85NKTP0000K0','85OXRW0000K0','85P2V20000K0')

