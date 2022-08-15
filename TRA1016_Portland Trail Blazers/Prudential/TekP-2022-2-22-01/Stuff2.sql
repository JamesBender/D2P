--[5:22 PM] Marie Thomerson
--  ---==========================================
-- --   -- Insert into BDM Reason code 201 and 204
-- --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EPORPRUDEX]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           --,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmIsPQB]
    )
    SELECT rectype = 'EMP'
        ,xCOID
        ,xEEID
        ,''--DbnDepRecID
        ,''--DbnDepRecID
        ,'QB'
        ,'Data Inserted for LTD'
        ,'Emp'
        --,EEcDateOfBirth
        ,'LTD'
        ,'EE'
        ,'A'--DbnBenStatus
        ,EecDateofLastHire
        ,'' 
        ,''
        --,''
        ,''
        ,''
        ,''
        ,''
        ,'N'
    FROM  dbo.U_EPORPRUDEX_EEList WITH (NOLOCK)
     JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
		AND EecCOID = xCOID
		WHERE eecEEtype = '001'
