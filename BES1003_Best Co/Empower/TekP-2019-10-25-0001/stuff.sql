SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, RN
				FROM (SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
						FROM dbo.EmpHStat WITH (NOLOCK) 
						WHERE EshEmplStatus = 'L') AS LOA_Dates 
				WHERE RN = 1
						AND EshEEID IN ('BV8TIO00H0K0','BV8TKZ0140K0','BV8TNY0020K0','BV8TR10010K0','CUS3DN000020');

select * from dbo.U_EBSTEMP401_Audit

/*
sp_GetEEID BV8TIO00H0K0 --Shoe,Patricia
sp_GetEEID BV8TKZ0140K0 --Lowery,Tasha
sp_GetEEID BV8TNY0020K0 --Vestal,Joni
sp_GetEEID BV8TR10010K0 --Vreeland,Clyde
sp_GetEEID CUS3DN000020 --Phifer,Kiarra
*/



