select drvQualifiedEventDate, drvQualifyingEvent, drvCobraBegins, * from dbo.U_EOPTCBRAQB_drvTbl
where drvEEID IN ('AMWDES0000K0', 'AMWDOO0000K0') --drvNameLast IN ('Royer', 'Schmidt') -- Lea "undid" the special Cobra stuff


/*

Can you also check these deps that had ConCOBRAReason = NLED or LEVNT3?  The client is indicating they did not get sent over either.
Employee: Douglas Royer
Child: Jacob Royer

 

Employee: Matthew Schmidt

Child: Caleb Schmidt

*/



--select drvQualifiedEventDate, drvQualifyingEvent, drvCobraBegins, * from dbo.U_EOPTCBRAQB_drvTbl
--where drvQualifyingEvent IS NULL OR drvCobraBegins IS NULL OR drvCobraBegins IS NULL

--select EecEmplStatus, * from EmpComp where EecEEID IN ('C9W5ES0000K0','CBWSFL0010K0') AND EecEmplStatus = 'A'
--where drvSort2 like '%NLED'

--select distinct EecTermReason from EmpComp A --WHERE EecEEID IN (select drvEEID from dbo.U_EOPTCBRAQB_drvTbl) 
--Order by A.EecTermReason

select * from EmpComp where EecEEID = 'CBWSFL0010K0'

select BdmChangeReason, * FROM dbo.U_dsi_BDM_EOPTCBRAQB WITH (NOLOCK) where BdmEEID = 'CBWSFL0010K0'
select BdmChangeReason, * FROM dbo.U_dsi_BDM_EOPTCBRAQB WITH (NOLOCK) --where BdmEEID = 'CBWSFL0010K0'
--select BdmCobraReason, * FROM dbo.U_dsi_BDM_EOPTCBRAQB WITH (NOLOCK) where BdmEEID IN ('AMWDES0000K0', 'AMWDOO0000K0')
--select ConDateOfCobraEvent, * from Contacts where ConEEID IN ('AMWDES0000K0', 'AMWDOO0000K0')

-- LOA w/o benefits




