select EdhEffDate, EdhChangeReason, * from EmpHDed  A WHERE EdhEEID IN ('AMWDES0000K0'/*, 'AMWDOO0000K0'*/) AND EdhDedCode in (Select DedCode FROM dbo.U_EOPTCBRAQB_DedList) order by A.EdhEffDate desc


select  BdmChangeReason, BdmCobraReason,* FROM dbo.U_dsi_BDM_EOPTCBRAQB WITH (NOLOCK) 
where BdmEEID IN ('AMWDES0000K0', 'AMWDOO0000K0')

Select * from [dbo].[fn_MP_CustomFields_iContacts_Export] (NULL,NULL,NULL,NULL)
Select ConNamefirst,connamelast,* from Contacts where Consystemid IN ('AO2MA70LX0K0','AO2MA70PF0K0')



INSERT INTO dbo.U_dsi_BDM_EOPTCBRAQB (BdmRecType, BdmCOID, BdmEEID, BdmDepRecID, BdmSystemID, BdmRunID, BdmRelationship, BdmDedCode, BdmBenOption, BdmBenStartDate, BdmBenStopDate, BdmChangeReason, BdmCobraReason, BdmEEAmt)
(SELECT DISTINCT 'DEP', EdhCOID, EdhEEID, ConSystemID, SystemId /*??*/, 'NPM', ConRelationship, EdhDedCode, EdhBenOption, EdhBenStartDate, EdhBenStopDate, EdhChangeReason, EdhChangeReason, EdhEEAmt
FROM dbo.EmpHDed WITH (NOLOCK)
	JOIN dbo.Contacts WITH (NOLOCK)
		ON EdhEEID = ConEEID
	JOIN (Select * from [dbo].[fn_MP_CustomFields_iContacts_Export] (NULL,NULL,NULL,NULL)) AS Cobra_Fields
		ON ConSystemId = SystemID
	JOIN dbo.U_EOPTCBRAQB_DedList
		ON DedCode = EdhDedCode
WHERE EdhEffDate BETWEEN '6/1/2020' AND '6/30/2020')

