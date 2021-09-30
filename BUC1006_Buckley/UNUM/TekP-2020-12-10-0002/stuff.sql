--sp_getEEID 'Buckley' -- CR6LWJ000030

select drvEffectiveDate, * from dbo.U_EBVLADDEXP_drvTbl
where drvEEID = 'CR6LWJ000030'


select * FROM dbo.U_EBVLADDEXP_Audit WITH (NOLOCK)
where AudEEID = 'CR6LWJ000030'

