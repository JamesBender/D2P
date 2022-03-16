/*select drvInitialSort, drvSubSort, drvREF01_RefNumberQual1, drvREF01_RefNumberQual2, * from dbo.U_EBSHLDH834_DrvTbl A
where drvEEID = 'CZS2CD000020'
order by A.drvInitialSort, A.drvSubSort*/


--sp_getEEID 'Kuhn' -- CZS2CD000020

select distinct * from dbo.U_EBSHLDH834_File
where InitialSort = '002823813'
order by InitialSort, SubSort