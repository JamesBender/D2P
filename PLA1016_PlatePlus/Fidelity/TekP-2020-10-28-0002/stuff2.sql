--sp_getEEID 'Blackmore' -- CWSJ8Y000020


select * from dbo.U_EFD401KHSA_drvTbl_01
where drvEEID = 'CWSJ8Y000020'


--
select * from dbo.U_EFD401KHSA_Employees where xEEID = 'CWSJ8Y000020'

select * from dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK) where BdmEEID = 'CWSJ8Y000020'

select * from dbo.U_EFD401KHSA_PDedHist WITH (NOLOCK) where pdhEEID = 'CWSJ8Y000020'
select * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) where EedFormatCode = 'EFD401KHSA' and EedEEID = 'CWSJ8Y000020'

select EedDedCode, * from EmpDed WHERE EedEEID = 'CWSJ8Y000020' and EedDedCode IN ('401M','ROP','40P','HSACF','HSACI','HSAF','HSAI','HSAER')
select * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) where EedFormatCode = 'EFD401KHSA' and EedEEID = 'CWSJ8Y000020'

select * from dbo.U_EFD401KHSA_drvTbl_19 where drvEEID = 'CWSJ8Y000020'

select * from dbo.U_EFD401KHSA_drvTbl_HS where drvEEID = 'CWSJ8Y000020'

--select * from dbo.U_EFD401KHSA_EEList where xEEID = 'CWSJ8Y000020'

/*select Record60Change, Record61Change, emailAddress, *
FROM dbo.U_EFD401KHSA_EEList
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON O2.OrgCode = EecOrgLvl2
        AND O2.OrgLvl = '2'
    LEFT JOIN (
        -- Get Record Set Changes based on Audit Fields
        SELECT audEEID
            ,Record01Change = MAX(CASE WHEN audFieldName IN ('EepNameFirst','EepNameLast','EepNameMiddle','EepGender','EepMaritalStatus') THEN 'Y' ELSE 'N' END)
            ,Record02DChange = MAX(CASE WHEN audFieldName IN ('EecDateOfOriginalHire','EepDateOfBirth','EecDateOfTermination') THEN 'Y' ELSE 'N' END)
            ,Record02EChange = MAX(CASE WHEN audFieldName IN ('EecEmpNo') THEN 'Y' ELSE 'N' END)
            ,Record03Change = MAX(CASE WHEN audFieldName IN ('EepAddressLine1','EepAddressLine2','EepAddressLine3') THEN 'Y' ELSE 'N' END)
            ,Record04Change = MAX(CASE WHEN audFieldName IN ('EepAddressCity','EepAddressState','EepAddressZipCode') THEN 'Y' ELSE 'N' END)
            ,Record05Change = MAX(CASE WHEN audFieldName IN ('EepAddressCountry') THEN 'Y' ELSE 'N' END)
            ,Record06Change = MAX(CASE WHEN audFieldName IN ('OrgDesc') THEN 'Y' ELSE 'N' END)
            ,Record11Change = MAX(CASE WHEN audFieldName IN ('EecEmplStatus') THEN 'Y' ELSE 'N' END)
            ,Record36Change = MAX(CASE WHEN audFieldName IN ('EecOrglvl2') THEN 'Y' ELSE 'N' END)
            ,Record60Change = MAX(CASE WHEN audFieldName IN ('EecFullTimeOrPartTime','EecOrgLvl1','EecOrgLvl2','EecLocation','EecUnionLocal','EecPayPeriod') THEN 'Y' ELSE 'N' END)
            ,Record61Change = MAX(CASE WHEN audFieldName IN ('EecDateOfLastHire','EecDateOfRetirement') THEN 'Y' ELSE 'N' END)
            ,audNewHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,audReHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,audTerm = MAX(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END)
            ,audSalaryChange = max(CASE  WHEN  audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)
            ,emailAddress = max(CASE  WHEN  audFieldName = 'EepEmailAddress' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)

        FROM dbo.U_EFD401KHSA_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID
	where xEEID = 'CWSJ8Y000020';*/