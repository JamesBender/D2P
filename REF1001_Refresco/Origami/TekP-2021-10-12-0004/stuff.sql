select top 10 AdhFormatName, * from ascDefH 
where AdhFormatName like 'Origami%'


SELECT * FROM dbo.AscDefF WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EOPTHSAEX2')
SELECT * FROM dbo.AscDefF WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EORIGAMIEXZ0')

--SELECT * FROM dbo.AscDefF WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EORIGAMIEXZ0')

SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EORIGAMIEX' ORDER BY RunID DESC;