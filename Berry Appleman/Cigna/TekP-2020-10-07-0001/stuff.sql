select drvExemptIndicator, drvHoursWorkedPerWeek, drvActualAnnualHours, * from dbo.U_ECIGFMLAEX_drvTbl
where drvEEID IN ('BT1DUP0000K0','APFEP20000K0','DGYCT0000040')

--sp_getEEID 'Reyes'