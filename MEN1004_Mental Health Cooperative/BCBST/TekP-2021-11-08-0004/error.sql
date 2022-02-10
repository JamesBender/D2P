--select top 25 * from dbo.U_dsi_InterfaceActivityLog Where FormatCode = 'EBCBSHW834' order by RunId DESC

SELECT TOP (100) * 
FROM [dbo].[U_dsi_InterfaceProcesses] 
WHERE FormatCode = 'EBCBSHW834' 
ORDER BY [DateTimeStamp] DESC



-- bcp ULTIPRO_WPMHCOO.dbo.dsi_vwEBCBSHW834_Export out "\\us.saas\EW4\EW45\Downloads\V10\Exports\MHCOO\EmployeeHistoryExport\EBCBSHW834_20220203" -T -S"EW4WUP5DB01" -c -t -r~\n
-- bcp ULTIPRO_WPMHCOO.dbo.dsi_vwEBCBSHW834_Export out "\\us.saas\EW4\EW45\Downloads\V10\Exports\MHCOO\EmployeeHistoryExport\EBCBSHW834_20220203" -T -S"EW4WUP5DB01" -c -t -r~\n