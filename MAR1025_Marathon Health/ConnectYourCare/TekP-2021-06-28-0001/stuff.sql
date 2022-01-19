--Interface Activity
SELECT TOP 25 * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCFSAHSA' ORDER BY RunID DESC

--Interface Process Steps
SELECT TOP (100) * 
FROM [dbo].[U_dsi_InterfaceProcesses] 
WHERE FormatCode = 'ECYCFSAHSA' 
ORDER BY [DateTimeStamp] DESC

/*

bcp ULTIPRO_WPMARAT.dbo.dsi_vwECYCFSAHSA_Export out "\\us.saas\EW2\EW24\Downloads\V10\Exports\MARAT\EmployeeHistoryExport\ECYCFSAHSA_20220111a.txt" -T -S"EW2WUP4DB01" -c -t

bcp ULTIPRO_WPMARAT.dbo.dsi_vwECYCFSAHSA_Export out "\\us.saas\EW2\EW24\Downloads\V10\Exports\MARAT\EmployeeHistoryExport\ECYCFSAHSA_20220111a.txt" -T -S"EW2WUP4DB01" -c -t

*/