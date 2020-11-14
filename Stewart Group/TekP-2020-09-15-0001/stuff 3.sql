select * from dbo.U_EOPTMRXEXP_drvTbl 
where drvEEID = 'BLKKOT0000K0'
--where drvNameLast = 'Lowe'

SELECT ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY ConEEID, /*ConSystemID*/ CASE WHEN ConRelationship IN ('SPS') THEN 1 ELSE 2 END) AS Con_RN, * 
            FROM dbo.Contacts WITH (NOLOCK)
            /*JOIN dbo.U_dsi_BDM_EOPTMRXEXP A WITH (NOLOCK)
                ON ConSystemID = A.BdmDepRecID*/
where ConEEID = 'BLKKOT0000K0'

Select * from dbo.U_dsi_BDM_EOPTMRXEXP B WITH (NOLOCK)
where BdmEEID  = 'BLKKOT0000K0'


select EEdCOID, EedDedCode, * from EmpDed 
where EedEEID = 'BLKKOT0000K0'
and EedDedCode IN ('AMEDS','MEDS')


