--  Divorce and OverAge
----==========================================
---- Insert into BDM Reason code 201 and 204
----==========================================
    INSERT INTO [dbo].[U_dsi_BDM_ECOBRAQBEX]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]

    )
 Select rectype = 'DEP', EdhCoid, EdhEEID, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 204 Chg reason', 
            DbnRelationship, DbnDateOfBirth, EdhDedCode, edhBenStartDate,edhBenStopDate, edhBenStatusDate,'204'
            ,edhStartDate, edhStopDate, CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = 'ECOBRAQBEX'
            WHERE edhChangeReason in ('204') and edhBenstatusdate between @startdate and @enddate and dbnValidForExport = 'N'

INSERT INTO [dbo].[U_dsi_BDM_ECOBRAQBEX]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]

    )
 Select rectype = 'DEP', EdhCoid, EdhEEID, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 201 Chg reason', 
            DbnRelationship, DbnDateOfBirth, EdhDedCode, edhBenStartDate,edhBenStopDate, edhBenStatusDate,'201'
            ,edhStartDate, edhStopDate, 'Y'
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = 'ECOBRAQBEX'
            WHERE edhChangeReason in ('201') and edhBenstatusdate between @startdate and @enddate and dbnValidForExport = 'N'

 Delete from dbo.U_dsi_BDM_ECOBRAQBEX where bdmdedcode not in (Select dedcode from U_ECOBRAQBEX_DedList)