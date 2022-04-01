--sp_getEEID 'Becker' -- BOCW4H0IM0K0
--sp_getEEID 'Striefel' -- BOCW4J02Z0K0
--sp_getEEID 'Zabel' -- BOCW4N02N0K0

select * from dbo.U_EPRINC4012_D10
--where drvEEID = 'BOCW4H0IM0K0'
--where drvEEID = 'BOCW4J02Z0K0'
where drvEEID IN ('BOCW4H0IM0K0','BOCW4J02Z0K0','BOCW4N02N0K0')


--select * from dbo.U_EPRINC4012_Audit where audEEID = 'BOCW4H0IM0K0'

select * from dbo.U_EPRINC4012_EELIST where xEEID IN ('BOCW4H0IM0K0', 'BOCW4J02Z0K0','BOCW4N02N0K0') 
--select EecEEID, EecCOID, EecEmplStatus, * from EmpComp where EecEEID  IN ('BOCW4H0IM0K0', 'BOCW4J02Z0K0') 


/*select EecDateOfTermination, EecEmplStatus, *
FROM dbo.U_EPRINC4012_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN Company WITH (NOLOCK) 
    ON xCoID = cmpCOID
    JOIN dbo.EmpPers WITH (NOLOCK) 
    ON EepEEID = xEEID
    LEFT JOIN dbo.U_EPRINC4012_PEarHist WITH (NOLOCK)
    ON PehEEID = xEEID
where xEEID = 'BOCW4H0IM0K0'*/


/*
Select b.EecEmplStatus, EecTermReason, b.eeccoid, *
FROM dbo.U_EPRINC4012_EELIST a
    JOIN EmpComp b ON b.eeceeid = a.xeeid
    and b.eeccoid = a.xcoid
    WHERE  xEEID IN ('BOCW4H0IM0K0', 'BOCW4J02Z0K0') AND
	b.EecEmplStatus = 'T' and NOT EXISTS (SELECT 1 FROM U_EPRINC4012_Audit WHERE a.xeeid = audeeid)
    --AND EecTermReason != 'TRO' 
*/

