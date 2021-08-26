--sp_getEEID 'Psalidas' -- D089GJ000020
--sp_getEEID 'Greenstreet' -- CL40NI013020

select *  from dbo.U_EFD401KHSA_drvTbl_02D
--where drvEEID = 'D089GJ000020'
where drvEEID = 'CL40NI013020'


--select * from dbo.AscExp WHERE expFormatCode = 'EFD401KHSA' AND ExpExportCode = 'TEST_XOE'

--===================

/*
Can you please look at Donovan Psalidas's record?
He was correctly reported as Active with a contribution amount on the 7/30/21 (pay group WKLY) file - This file transmitted on 7/27/21.
His termination was entered on 7/29/21 and he wasn't reported as Terminated on files after 7/30/21.
*/

--sp_getEEID 'Psalidas' -- D089GJ000020

--select * from dbo.U_EFD401KHSA_drvTbl_02D
select * from dbo.U_EFD401KHSA_drvTbl_11
where drvEEID = 'D089GJ000020'