--sp_getEEID 'Sharif' -- DFD69N008020
--sp_getEEID 'Kamavarapu' -- BRJEZ500Q0K0
--sp_getEEID 'Flores' -- DQIL75000020
--sp_getEEID 'Walker' -- DGWH0X000020


--DECLARE @EEID VARCHAR(12) = 'DFD69N008020' -- Sharif
--DECLARE @EEID VARCHAR(12) = 'BRJEZ500Q0K0' -- Kamavarapu
--DECLARE @EEID VARCHAR(12) = 'DQIL75000020' -- Flores
DECLARE @EEID VARCHAR(12) = 'DGWH0X000020' -- Walker


select TermActionCode,TermActionEffDate, ActActionCode, ActActionEffDate, OEjhReason, OEjhJobEffDate, EshStatusStopDate
	-- Term Action Code/TermActionEffDate - Pulled from audit table where audit action code (?) is 800 (termination)
	-- Act Action Code/ActActionEffDate - audit data for EmpHJob(EjhReason) and EmpComp (EecLeaveReason and EecJobChangeReason) where the new value is ('PDM11','PBIRTH','119','121','123','124','505','LTD','MAS','MFM','PADOPT','PFOSTR','PSURRO','UPBRTH','UPADPT','UPFOST','UPSURR','PERSNL','WKCOMP','PDM05','PDM610','RFL')
	-- OEjhReason/OEjhJobEffDate - most recent from Job History table where reason in ('100','101','400','401','800','TRI','TRO','200','201','CONV')
	-- most recent status stop date from EmpHStat status reason is PERSNL
	
	,CASE WHEN TermActionCode IS NOT NULL THEN  TermActionCode
    WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionCode ELSE OEjhReason END
    WHEN ActActionCode IS NOT NULL THEN ActActionCode 
    ELSE OEjhReason 
    END AS Col59

	,CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
        CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
        WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
        END
    WHEN TermActionCode IS NOT NULL THEN TermActionEffDate 
    WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
        CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
    WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
    ELSE OEjhJobEffDate 
    END AS Col60

	,CASE WHEN TermActionCode IS NOT NULL THEN TermActionDesc
    WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionDesc ELSE B.ActDesc END
    WHEN ActActionCode IS NOT NULL THEN ActActionDesc
    ELSE B.ActDesc 
    END AS Col61

	,CASE WHEN TermActionCode IS NOT NULL THEN TermActionEffDate 
    WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
        CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
    WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
    ELSE OEjhJobEffDate 
    END AS Col62
FROM dbo.U_EEMPYDEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    INNER JOIN dbo.JobCode WITH (NOLOCK)
        ON EecJobCode = JbcJobCode
    INNER JOIN dbo.[Location] WITH (NOLOCK)
        ON EecLocation = LocCode
    LEFT JOIN (    SELECT 
                        audEEID
                        ,audKey2
                        ,AudActionEffDate = MAX(audActionEffDate)
                    FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                    WHERE NULLIF(audActionCode, '') IS NOT NULL
                    AND audActionCode NOT IN ('ADDR', 'LOC')
                    GROUP BY audEEID, audKey2
                ) audMax
        ON audMax.audEEID = xEEId
        AND audMax.audKey2 = xCoID
    LEFT JOIN dbo.U_EEMPYDEMO_Audit aud WITH (NOLOCK)
        ON aud.audEEID = xEEId
        AND aud.audKey2 = xCoID
        AND aud.AudActionEffDate = audMax.AudActionEffDate
        AND NULLIF(aud.audActionCode, '') IS NOT NULL


    

    LEFT JOIN (
                SELECT audEEID, audKey2, audFieldName = MAX(audFieldName) ,AudActionEffDate = MAX(audActionEffDate), audActionCode =MAX (audActionCode), audactiondesc = MAX (audactiondesc), audNewValue = MAX(audNewValue)--actdesc =MAX(actdesc)
                FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                JOIN dbo.U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
                    ON actCode=audActionCode
                WHERE NULLIF(audActionCode, '') IS NOT NULL
                    AND audActionCode  IN ('ADDR', 'LOC','900','202','203','205','300','301','302','303','500','501','502','503','504','506','600','601','700','900','COFF','CONV','DCOR','EQI','HOME','PCEU','TRB','200','201')
                    
                            --('ADDR', 'LOC','202','203','205','300','301','302','303','500','501','502','503','504','506','600','601','700','900',
                            --'COFF','CONV','DCOR','EQI','HOME','PCEU','TRB','Z','121','123','124','LTD','MAS','MFM','PADOPT','PFOSTR',
                            --'PSURRO','UPBRTH','UPADPT','UPFOST','UPSURR','PERSNL','WKCOMP','PDM05','PDM610','RFL') 
                    GROUP BY audEEID, audKey2) audActive
                    ON audActive.audEEID = xEEId
                    AND audActive.audKey2 = xCoID




                  --  LEFT JOIN (SELECT audEEID, audKey2, audFieldName = MAX(audFieldName) ,AudActionEffDate = MAX(audActionEffDate), audActionCode =MAX (audActionCode), audactiondesc = MAX (audactiondesc), audNewValue = MAX(audNewValue), actdesc = MAX(actdesc)
                  -- FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                  --JOIN dbo.U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
                  -- ON actCode=audActionCode
                  --  WHERE NULLIF(audActionCode, '') IS NOT NULL
                  --  AND audFieldName = 'EjhEmplStatus'
                  --  AND audNewValue = 'L'
                  --  AND audActionCode  IN ('PBIRTH','PDM11','PDM05','LTD')
                    
                  --          --('ADDR', 'LOC','202','203','205','300','301','302','303','500','501','502','503','504','506','600','601','700','900',
                  --          --'COFF','CONV','DCOR','EQI','HOME','PCEU','TRB','Z','121','123','124','LTD','MAS','MFM','PADOPT','PFOSTR',
                  --          --'PSURRO','UPBRTH','UPADPT','UPFOST','UPSURR','PERSNL','WKCOMP','PDM05','PDM610','RFL') 
                  --  GROUP BY audEEID, audKey2) audLeave
                  --  ON audLeave.audEEID = xEEId
                  --  AND audLeave.audKey2 = xCoID





 LEFT JOIN (Select * from (Select ejheeid,ejhcoid,ejhReason,ejhJobEffDate,ejhEmplStatus,actDesc,actcode,
               ROW_NUMBER() OVER (PARTITION BY ejheeid,ejhcoid ORDER BY ejhJobEffDate desc) 
               row_num from dbo.EmpHJob  
              Join dbo.U_EEMPYDEMO_Mapping_Actions 
               on ejhReason = ActCode            
              -- where ejhEmplStatus = 'A'
               AND ejhReason NOT IN ('ADDR', 'LOC','900','202','203','205','300','301','302','303','500','501','502','503','504','506','600','601','700','900','COFF','CONV','DCOR','EQI','HOME','PCEU','TRB')) JobHistActive
               Where JobHistActive.row_num = 1 ) as JobActive
               on JobActive.ejheeid = xEEId
               and JobActive.ejhcoid = xcoid


--LEFT JOIN (Select * from (Select ejheeid ejheeidleave,ejhcoid ejhcoidleave,ejhReason ejhreasonleave,ejhJobEffDate ejhJobEffDateleave ,ejhEmplStatus ejhEmplStatusleave,actDesc actDescleave, 
--               ROW_NUMBER() OVER (PARTITION BY ejheeid,ejhcoid ORDER BY ejhJobEffDate desc) 
--               row_num from dbo.EmpHJob  
--               Join dbo.U_EEMPYDEMO_Mapping_Actions 
--               on ejhReason = ActCode
--               where ejhEmplStatus = 'L'
--               AND ejhReason in ('PBIRTH','PDM11','PDM05','LTD')) JobHistLeave
--               Where JobHistLeave.row_num = 1 ) as JobLeave
--               on JobLeave.ejheeidleave = xEEId
--               and JobLeave.ejhcoidleave = xcoid



    LEFT JOIN (SELECT Distinct audeeid, audKey2, AudActionEffDate = MAX(audActionEffDate)
                FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                WHERE audRowNo = '1'
                AND audFieldName = 'EjhJobEffDate'
                GROUP BY audeeid,audKey2)auddate
                ON auddate.audEEID = xEEId
                AND auddate.audKey2 = xCoID

    /*LEFT JOIN dbo.U_EEMPYDEMO_Audit aud WITH (NOLOCK)
               ON aud.audEEID = xEEId
              AND aud.audKey2 = xCoID
             AND aud.AudActionEffDate = audactive.AudActionEffDate
             AND NULLIF(aud.audActionCode, '') IS NOT NULL*/

    LEFT JOIN dbo.U_EEMPYDEMO_PEarHist
        ON xEEID = PehEEID

    LEFT JOIN (
                SELECT EjhEEID AS OEjhEEID, EjhCOID AS OEjhCOID, EjhReason AS OEjhReason, EjhJobEffDate AS OEjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM EmpHJob
                        WHERE EjhReason IN ('100','101','400','401','800','TRI','TRO','200','201','CONV')) AS EjhList
                WHERE RN = 1) AS OuterEjhList
        ON OEjhEEID = xEEID
        AND OEjhCOID = xCOID
    LEFT JOIN dbo.U_EEMPYDEMO_Mapping_Actions B WITH (NOLOCK)
        ON OEjhReason = B.ActCode
    LEFT JOIN (            
                SELECT ActEEID, ActCOID, ActActionCode, ActActionEffDate, ActActionDesc
                FROM (
                        SELECT AudEEID AS ActEEID, AudKey2 AS ActCOID, AudNewValue AS ActActionCode, actDesc AS ActActionDesc, audDateTime AS ActActionEffDate, ROW_NUMBER() OVER (PARTITION BY AudEEID, AudKey2 ORDER BY AudActionEffDate DESC) AS RN
                        FROM dbo.U_EEMPYDEMO_Audit_Action WITH (NOLOCK) 
                        JOIN U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
                            ON actCode = audNewValue
                        ) AS InAct
                WHERE RN = 1) AS Actions
        ON ActEEID = xEEID
        AND ActCOID = xCOID
    LEFT JOIN (
                SELECT audEEID AS TermEEID, AudKey2 AS TermCOID, audActionCode AS TermActionCode, AudActionDesc AS TermActionDesc, audActionEffDate AS TermActionEffDate 
                FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                WHERE audActionCode = '800'
                AND audActionEffDate IS NOT NULL) as InnerTerm
        ON TermEEID = xEEID
        AND TermCOID = xCOID
    LEFT JOIN (
                select EshEEID, EshCOID, MAX(EshStatusStopDate) AS EshStatusStopDate
                FROM EmpHStat
                WHERE EshEmplStatusReason = 'PERSNL'
                GROUP BY EshEEID, EshCOID) AS PERSNL
        ON EshEEID = xEEID
        AND EshCOID = xCOID
	LEFT JOIN (
				SELECT EshEEID AS LeaveEEID, EshCOID AS LeaveCOID
					,MAX(EshStatusStopDate) AS LeaveStopDate
				FROM dbo.EmpHStat WITH (NOLOCK)
				WHERE EshEmplStatus = 'L'
					AND EshStatusStopDate IS NOT NULL
				GROUP BY EshEEID, EshCOID) AS LeaveReturnDate
		ON LeaveEEID = xEEID
		AND LeaveCOID = xCOID
where xEEID = @EEID