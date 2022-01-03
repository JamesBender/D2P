--sp_getEEID 'Burcker' -- DBHTUX000020
--sp_getEEID 'Fiorella Dybski' -- 9U6ZT501T0K0
--sp_getEEID 'Her' -- DQTUPS000020
--sp_getEEID 'Rosolen' -- 9U6ZWF0520K0
--sp_getEEID 'Ridley' -- DW82WU000020

select  drvStatusChangeDate, drvStatusChangeReason,* from dbo.U_ECUNA401QF_drvTbl
where drvEEID IN ('DBHTUX000020','9U6ZT501T0K0','DQTUPS000020','9U6ZWF0520K0','DW82WU000020')

select * from dbo.U_ECUNA401QF_Audit
where audEEID IN ('DBHTUX000020','9U6ZT501T0K0','DQTUPS000020','9U6ZWF0520K0','DW82WU000020')