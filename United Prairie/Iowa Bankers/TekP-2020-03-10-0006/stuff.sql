--select * from dbo.U_EIWABNKMED_DrvTbl where drvNM103_NameLast1 = 'Test' -- DDYMIB000030

select drvSubSort, drvDTP00_DateTime_348, drvDTP03_DateTimePeriod_348, drvDTP00_DateTime_349, drvDTP03_DateTimePeriod_349, * from dbo.U_EIWABNKMED_DrvTbl_2300 where drvEEID = 'DDYMIB000030'


select * from dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) where bdmEEID = 'DDYMIB000030'

SELECT AudEEID, AudKey2 AS AudCOID, AudOldValue AS OldBenOption, AudNewValue AS NewBenOption
                FROM dbo.U_EIWABNKMED_Audit
                WHERE audTableName = 'EmpDed'
                    AND audFieldName = 'EedBenOption'
                    AND audAction = 'Update'
                    AND AudRowNo = 1
                    AND AudOldValue NOT IN ('Z')
                    AND AudNewValue NOT IN ('Z')
					and audEEID = 'DDYMIB000030'	