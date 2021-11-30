/**********************************************************************************

EJH401KRER: John Hancock 401K Export V2

FormatCode:     EJH401KRER
Project:        John Hancock 401K Export V2
Client ID:      REF1001
Date/time:      2021-11-11 08:47:27.820
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_RBUS

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EJH401KRER_SavePath') IS NOT NULL DROP TABLE dbo.U_EJH401KRER_SavePath


-----------
-- Create U_dsi_RipoutParms if it doesn't exist
-----------

IF OBJECT_ID('U_dsi_RipoutParms') IS NULL BEGIN

   CREATE TABLE dbo.U_dsi_RipoutParms (
   rpoFormatCode  VARCHAR(10)   NOT NULL,
   rpoParmType    VARCHAR(64)   NOT NULL,
   rpoParmValue01 VARCHAR(1024) NULL,
   rpoParmValue02 VARCHAR(1024) NULL,
   rpoParmValue03 VARCHAR(1024) NULL,
   rpoParmValue04 VARCHAR(1024) NULL,
   rpoParmValue05 VARCHAR(1024) NULL
)
END


-----------
-- Clear U_dsi_RipoutParms
-----------

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EJH401KRER'


-----------
-- Add paths to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02)
SELECT

FormatCode,
'Path',
CfgName,
CfgValue

FROM dbo.U_Dsi_Configuration
WHERE FormatCode = 'EJH401KRER'
AND CfgName LIKE '%path%'


-----------
-- Add AscExp expSystemIDs to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02) 
SELECT

ExpFormatCode,
'expSystemID',
ExpExportCode,
ExpSystemID

FROM dbo.AscExp
WHERE ExpFormatCode = 'EJH401KRER'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EJH401KRER')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EJH401KRER'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EJH401KRER'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EJH401KRER'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EJH401KRER'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EJH401KRER'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EJH401KRER'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EJH401KRER'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EJH401KRER'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EJH401KRER'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEJH401KRER_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEJH401KRER_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EJH401KRER') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJH401KRER];
GO
IF OBJECT_ID('U_EJH401KRER_TrailerTbl') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRER_TrailerTbl];
GO
IF OBJECT_ID('U_EJH401KRER_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRER_PTaxHist];
GO
IF OBJECT_ID('U_EJH401KRER_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRER_PEarHist];
GO
IF OBJECT_ID('U_EJH401KRER_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRER_PDedHist];
GO
IF OBJECT_ID('U_EJH401KRER_File') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRER_File];
GO
IF OBJECT_ID('U_EJH401KRER_EEList') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRER_EEList];
GO
IF OBJECT_ID('U_EJH401KRER_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRER_drvTbl];
GO
IF OBJECT_ID('U_EJH401KRER_DedList') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRER_DedList];
GO
IF OBJECT_ID('U_EJH401KRER_CompYTD') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRER_CompYTD];
GO
