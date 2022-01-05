--sp_getEEID 'Boufford' -- DPHGIQ000020
--sp_getEEID 'Kotowych' -- DPHGGR008020

select * from dbo.U_ESUNLIF2_Member -- 382
where drvEEID = 'DPHGGR008020' -- 'DPHGIQ000020'


select * from dbo.U_ESUNLIF2_EEList
where xEEID = 'DPHGGR008020' -- 'DPHGIQ000020'


SELECT * --distinct AudEEID 
						FROM dbo.U_ESUNLIF2_Audit WITH (NOLOCK) 
						WHERE AudFieldName = 'EecEmplStatus' 
							AND ISNULL(AudNewValue, '') = 'A' --IN ('T','R') 
							AND ISNULL(AudOldValue, '') = 'R'
							AND audEEID= 'DPHGGR008020' -- 'DPHGIQ000020'



/*
select  EedBenStopDate, * from dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)                
        WHERE EedEEID = 'DPHGGR008020'
        AND EedFormatCode = 'ESUNLIF2'
        AND EedValidForExport = 'Y'
	ORDER BY CASE WHEN EedBenStopDate IS NULL THEN 1 ELSE 0 END, EedBenStopDate
	*/