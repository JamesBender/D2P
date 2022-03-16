select * from dbo.U_EVOYPORTEX_drvTbl where drvEEID = 'CM77QB00S020'

--sp_getEEID 'Williams' -- CM77QB00S020

select * from dbo.U_dsi_BDM_EVOYPORTEX WITH (NOLOCK) where BdmEEID = 'CM77QB00S020'

select ConSystemID, * from  dbo.Contacts WITH (NOLOCK)
        where --ConEEID = xEEID
        --AND ConSystemID = BdmDepRecID
        --AND 
		ConRelationship IN ('SPS','DP')
        AND ConIsDependent = 'Y'
		and ConEEID = 'CM77QB00S020'