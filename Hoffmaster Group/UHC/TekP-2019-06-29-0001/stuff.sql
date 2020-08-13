/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ProcessID]
      ,[FormatCode]
      ,[ExportCode]
      ,[StepID]
      ,[StepName]
      ,[StepDesc]
      ,[StepValue]
      ,[IsBaseLine]
      ,[DateTimeStamp]
  FROM [ULTIPRO_WPHOFFG].[dbo].[U_dsi_InterfaceProcesses]
  where FormatCode = 'EHFSAELIGE'