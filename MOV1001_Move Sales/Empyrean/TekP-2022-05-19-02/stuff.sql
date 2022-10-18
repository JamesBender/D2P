DECLARE @EEID VARCHAR(12) = 'EBKR7U000020'

select drvActionCode, drvActionCodeEffectiveDate, * from dbo.U_EEMPYDEMO_DrvTbl_D11 where drvEEID = @EEID

--select MIN(audDateTime) from dbo.vw_AuditData where audKey1Value = @EEID 

select top 100 * from dbo.vw_AuditData A WITH (NOLOCK)  where audKey1Value = @EEID 
AND audTableName IN ('EmpComp','EmpHJob')
AND audNewValue = '100'
order by A. audDateTime DESC




--select * from U_EEMPYDEMO_Mapping_Actions

--SELECT audEEID AS TermEEID, AudKey2 AS TermCOID, audActionCode AS TermActionCode, AudActionDesc AS TermActionDesc, audActionEffDate AS TermActionEffDate 
--                FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
--                WHERE audActionCode = '800'
--                AND audActionEffDate IS NOT NULL
--				and audEEID = @EEID

--SELECT ActEEID, ActCOID, ActActionCode, ActActionEffDate, ActActionDesc
--                FROM (
--                        SELECT AudEEID AS ActEEID, AudKey2 AS ActCOID, AudNewValue AS ActActionCode, actDesc AS ActActionDesc, audDateTime AS ActActionEffDate, ROW_NUMBER() OVER (PARTITION BY AudEEID, AudKey2 ORDER BY AudActionEffDate DESC) AS RN
--                        FROM dbo.U_EEMPYDEMO_Audit_Action WITH (NOLOCK) 
--                        JOIN U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
--                            ON actCode = audNewValue
--                        ) AS InAct
--                WHERE RN = 1
--				and ActEEID =  @EEID


SELECT AudEEID AS ActEEID, AudKey2 AS ActCOID, AudNewValue AS ActActionCode, /*actDesc AS ActActionDesc,*/ audDateTime AS ActActionEffDate, ROW_NUMBER() OVER (PARTITION BY AudEEID, AudKey2 ORDER BY AudActionEffDate DESC) AS RN
                        FROM dbo.U_EEMPYDEMO_Audit_Action WITH (NOLOCK) 
                        --JOIN U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
                        --    ON actCode = audNewValue
						where audEEID = @EEID

select CASE WHEN EecEmplStatus = 'A' AND LpStatus = 'L' AND LPStopDate > OEjhJobEffDate THEN 'RFL'
                            WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                    CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionCode ELSE OEjhReason END
                            WHEN ActActionCode IS NOT NULL THEN ActActionCode 
							WHEN TermActionCode IS NOT NULL THEN  TermActionCode
                            
                            ELSE OEjhReason 
                            END
							,CASE WHEN EecEmplStatus = 'A' AND LpStatus = 'L' AND LPStopDate > OEjhJobEffDate THEN 'Return from Leave'
                                WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionDesc ELSE B.ActDesc END
                                WHEN ActActionCode IS NOT NULL THEN ActActionDesc
								WHEN TermActionCode IS NOT NULL THEN TermActionDesc
                                
                                ELSE B.ActDesc 
                                END 
							,EecEmplStatus
							,LpStatus = 'L'
							,LPStopDate
							,OEjhJobEffDate
							,TermActionCode
							,ActActionCode
							,OEjhReason
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

    --JOIN dbo.EmpHJob WITH (NOLOCK)
    --     ON EjhEEID = xEEID 
    --     AND EjhCOID = xCOID

    LEFT JOIN (
                SELECT A.EshEEID AS LpEEID, A.EshCOID AS LPCOID, A.EshEmplStatus AS LpStatus, A.EshStatusStartDate AS LpStartDate, A.EshStatusStopDate AS LpStopDate, ROW_NUMBER() OVER(PARTITION BY A.EshEEID, A.EshCOID ORDER BY A.EshStatusStartDate DESC) AS LpRN
                FROM EmpHStat A 
                JOIN (
                    SELECT EshEEID, EshCOID, MAX(EshStatusStartDate) AS MaxStartDate
                    FROM EmpHStat
                    GROUP BY EshEEID, EshCOID
                ) B
                    ON A.EshEEID = B.EshEEID
                    AND A.EshCOID = B.EshCOID
                WHERE EshStatusStartDate < B.MaxStartDate) PrevStatus
    ON LpEEID = xEEID
    AND LpCOID = xCOID
    AND LpRN = 1
where xEEID = @EEID
    ;
