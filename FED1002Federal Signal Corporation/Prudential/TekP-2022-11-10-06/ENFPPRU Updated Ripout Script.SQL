/**********************************************************************************

ENFPPRU: NFP Federal Signal Export

FormatCode:     ENFPPRU
Project:        NFP Federal Signal Export
Client ID:      FED1002
Date/time:      2023-05-16 12:45:45.277
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    N12
Server:         N1SUP2DB54
Database:       ULTIPRO_FSCORP
Web Filename:   FED1002_78787_EEHISTORY_ENFPPRU_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ENFPPRU_SavePath') IS NOT NULL DROP TABLE dbo.U_ENFPPRU_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ENFPPRU'


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
WHERE FormatCode = 'ENFPPRU'
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
WHERE ExpFormatCode = 'ENFPPRU'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENFPPRU')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ENFPPRU'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ENFPPRU'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ENFPPRU'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ENFPPRU'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ENFPPRU'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ENFPPRU'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ENFPPRU'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ENFPPRU'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ENFPPRU'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwENFPPRU_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENFPPRU_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENFPPRU') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENFPPRU];
GO
IF OBJECT_ID('U_ENFPPRU_Prg') IS NOT NULL DROP TABLE [dbo].[U_ENFPPRU_Prg];
GO
IF OBJECT_ID('U_ENFPPRU_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENFPPRU_PDedHist];
GO
IF OBJECT_ID('U_ENFPPRU_Header') IS NOT NULL DROP TABLE [dbo].[U_ENFPPRU_Header];
GO
IF OBJECT_ID('U_ENFPPRU_File') IS NOT NULL DROP TABLE [dbo].[U_ENFPPRU_File];
GO
IF OBJECT_ID('U_ENFPPRU_EmpDed') IS NOT NULL DROP TABLE [dbo].[U_ENFPPRU_EmpDed];
GO
IF OBJECT_ID('U_ENFPPRU_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENFPPRU_EEList];
GO
IF OBJECT_ID('U_ENFPPRU_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENFPPRU_drvTbl];
GO
IF OBJECT_ID('U_ENFPPRU_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENFPPRU_DedList];
GO
IF OBJECT_ID('U_ENFPPRU_cmpTbl') IS NOT NULL DROP TABLE [dbo].[U_ENFPPRU_cmpTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ENFPPRU','NFP Federal Signal Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ENFPPRUZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENFPPRUZ0','1','H','01','1',NULL,'H',NULL,NULL,'"H"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENFPPRUZ0','7','H','01','2',NULL,'Control Number',NULL,NULL,'"59963"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENFPPRUZ0','40','H','01','3',NULL,'Feed Type',NULL,NULL,'"Federal Signal Corp"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENFPPRUZ0','8','H','01','4',NULL,'Feed Layout Version Number',NULL,NULL,'"drvCurrentDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENFPPRUZ0','6','H','01','5',NULL,'Current Date',NULL,NULL,'"drvCountRFRows"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENFPPRUZ0','1','H','01','6',NULL,'Row Counter',NULL,NULL,'"F"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENFPPRUZ0','6','H','01','7',NULL,'Customer Name',NULL,NULL,'"6"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENFPPRUZ0','50','D','10','1',NULL,'1. Control Number',NULL,NULL,'"59963"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENFPPRUZ0','50','D','10','2',NULL,'2. Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENFPPRUZ0','20','D','10','3',NULL,'3. Employee ID',NULL,NULL,'"drvEmpNo"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENFPPRUZ0','50','D','10','4',NULL,'5. First Name',NULL,NULL,'"drvNameLast"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENFPPRUZ0','20','D','10','5',NULL,'4. Last Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENFPPRUZ0','20','D','10','6',NULL,'6. Middle Initial',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENFPPRUZ0','20','D','10','7',NULL,'7. Residence Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENFPPRUZ0','20','D','10','8',NULL,'8. Residence Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENFPPRUZ0','20','D','10','9',NULL,'9. Residence City',NULL,NULL,'"drvCity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENFPPRUZ0','20','D','10','10',NULL,'10. Residence State',NULL,NULL,'"drvState"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENFPPRUZ0','20','D','10','11',NULL,'11. Residence Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENFPPRUZ0','20','D','10','12',NULL,'12. Residence Foreign Last Line',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENFPPRUZ0','50','D','10','13',NULL,'13. Mailing Address Line 1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENFPPRUZ0','50','D','10','14',NULL,'14. Mailing Address Line 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENFPPRUZ0','50','D','10','15',NULL,'15. Mailing City',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENFPPRUZ0','50','D','10','16',NULL,'16. Mailing State',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENFPPRUZ0','50','D','10','17',NULL,'17. Mailing Zip Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENFPPRUZ0','50','D','10','18',NULL,'18. Mailing Foreign Last Line',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENFPPRUZ0','50','D','10','19',NULL,'19. Home Phone',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENFPPRUZ0','50','D','10','20',NULL,'20. Work Phone',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENFPPRUZ0','50','D','10','21',NULL,'21. Work Phone Extension',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENFPPRUZ0','50','D','10','22',NULL,'22. Cell Phone Number',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENFPPRUZ0','50','D','10','23',NULL,'23. Employee Email',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENFPPRUZ0','20','D','10','24',NULL,'24. Date Of Birth',NULL,NULL,'"drvBirthDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENFPPRUZ0','20','D','10','25',NULL,'25. Gender',NULL,NULL,'"drvGender"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENFPPRUZ0','20','D','10','26',NULL,'26. Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENFPPRUZ0','20','D','10','27',NULL,'27. Job Title/Position',NULL,NULL,'"drvJobTitle"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENFPPRUZ0','20','D','10','28',NULL,'28. Employment Status',NULL,NULL,'"drvEmplStatus"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENFPPRUZ0','20','D','10','29',NULL,'29. Annual Salary',NULL,NULL,'"drvAnnSalary"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENFPPRUZ0','50','D','10','30',NULL,'30. Salary Frequency',NULL,NULL,'"13006"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENFPPRUZ0','50','D','10','31',NULL,'31. Year To Date Earnings',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENFPPRUZ0','50','D','10','32',NULL,'32. Earnings As Of Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENFPPRUZ0','50','D','10','33',NULL,'33. Daily Hours',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENFPPRUZ0','20','D','10','34',NULL,'34. Date of Hire',NULL,NULL,'"drvLastHire"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENFPPRUZ0','50','D','10','35',NULL,'35. Last Day Worked',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENFPPRUZ0','20','D','10','36',NULL,'36. Termination Date',NULL,NULL,'"drvTermDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENFPPRUZ0','20','D','10','37',NULL,'37. Work State',NULL,NULL,'"drvState"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENFPPRUZ0','50','D','10','38',NULL,'38. OSHA Job Classification',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENFPPRUZ0','50','D','10','39',NULL,'39. STD Branch Code (Buy Up)',NULL,NULL,'"drvDedBenCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ENFPPRUZ0','50','D','10','40',NULL,'40. STD Coverage Effective Date (Core)',NULL,NULL,'"drvBenStartDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ENFPPRUZ0','20','D','10','41',NULL,'41. STD Coverage End Date (Core)',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ENFPPRUZ0','50','D','10','42',NULL,'42. STD Branch Code (Buy Up)',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ENFPPRUZ0','20','D','10','43',NULL,'43. STD Coverage Effective Date (Buy Up)',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ENFPPRUZ0','50','D','10','44',NULL,'44. STD Coverage BuyUp End Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ENFPPRUZ0','20','D','10','45',NULL,'45. Statutory Branch Code',NULL,NULL,'"drvStatBranchCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ENFPPRUZ0','20','D','10','46',NULL,'46. Statutory Coverage Type',NULL,NULL,'"drvStatCovType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ENFPPRUZ0','20','D','10','47',NULL,'47. Statutory Effective Date',NULL,NULL,'"drvStatEffDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ENFPPRUZ0','50','D','10','48',NULL,'48. STD Coverage End Date (Core)',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ENFPPRUZ0','20','D','10','49',NULL,'49. LTD Branch Code (Core)',NULL,NULL,'"drvLTDBranchCore"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ENFPPRUZ0','20','D','10','50',NULL,'50. LTD Coverage Effective Date (Core)',NULL,NULL,'"drvLTDCovEffDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ENFPPRUZ0','50','D','10','51',NULL,'51. LTD Coverage End Date (Core)',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ENFPPRUZ0','20','D','10','52',NULL,'52. LTD Branch Code (Buy Up)',NULL,NULL,'"drvLTDBranchCodeBuyUp"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ENFPPRUZ0','20','D','10','53',NULL,'53. LTD Coverage Effective Date (Buy Up)',NULL,NULL,'"drvLTDCovEffDateBuyUp"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ENFPPRUZ0','50','D','10','54',NULL,'54. LTD Coverage BuyUp End Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ENFPPRUZ0','50','D','10','55',NULL,'55. Flat Benefit Rate',NULL,NULL,'"0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ENFPPRUZ0','50','D','10','56',NULL,'56. Comments',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ENFPPRUZ0','50','D','10','57',NULL,'57. W4 Filing Status',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ENFPPRUZ0','50','D','10','58',NULL,'58. W4 Number of Exemptions',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ENFPPRUZ0','50','D','10','59',NULL,'59. Additional Withholding amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ENFPPRUZ0','50','D','10','60',NULL,'60. Withholding State',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ENFPPRUZ0','50','D','10','61',NULL,'61. Work Location Zip Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ENFPPRUZ0','50','D','10','62',NULL,'62. Deduction 1 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ENFPPRUZ0','50','D','10','63',NULL,'63. Deduction 1 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ENFPPRUZ0','50','D','10','64',NULL,'64. Deduction 1 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ENFPPRUZ0','50','D','10','65',NULL,'65. Deduction 2 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ENFPPRUZ0','50','D','10','66',NULL,'66. Deduction 2 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ENFPPRUZ0','50','D','10','67',NULL,'67. Deduction 2 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ENFPPRUZ0','50','D','10','68',NULL,'68. Deduction 3 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ENFPPRUZ0','50','D','10','69',NULL,'69. Deduction 3 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ENFPPRUZ0','50','D','10','70',NULL,'70. Deduction 3 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ENFPPRUZ0','50','D','10','71',NULL,'71. Deduction 4 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ENFPPRUZ0','50','D','10','72',NULL,'72. Deduction 4 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ENFPPRUZ0','50','D','10','73',NULL,'73. Deduction 4 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ENFPPRUZ0','50','D','10','74',NULL,'74. Deduction 5 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ENFPPRUZ0','50','D','10','75',NULL,'75. Deduction 5 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ENFPPRUZ0','50','D','10','76',NULL,'76. Deduction 5 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ENFPPRUZ0','50','D','10','77',NULL,'77. Deduction 6 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ENFPPRUZ0','50','D','10','78',NULL,'78. Deduction 6 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ENFPPRUZ0','50','D','10','79',NULL,'79. Deduction 6 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ENFPPRUZ0','50','D','10','80',NULL,'80. Deduction 7 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ENFPPRUZ0','50','D','10','81',NULL,'81. Deduction 7 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ENFPPRUZ0','50','D','10','82',NULL,'82. Deduction 7 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ENFPPRUZ0','50','D','10','83',NULL,'83. Deduction 8 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ENFPPRUZ0','50','D','10','84',NULL,'84. Deduction 8 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ENFPPRUZ0','50','D','10','85',NULL,'85. Deduction 8 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ENFPPRUZ0','50','D','10','86',NULL,'86. Deduction 9 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ENFPPRUZ0','50','D','10','87',NULL,'87. Deduction 9 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ENFPPRUZ0','50','D','10','88',NULL,'88. Deduction 9 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ENFPPRUZ0','50','D','10','89',NULL,'89. Deduction 10 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ENFPPRUZ0','50','D','10','90',NULL,'90. Deduction 10 Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ENFPPRUZ0','50','D','10','91',NULL,'91. Deduction 10 Frequency',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ENFPPRUZ0','20','D','10','92',NULL,'92. Reporting Code 1',NULL,NULL,'"drvReportCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ENFPPRUZ0','50','D','10','93',NULL,'93. Reporting Code 2',NULL,NULL,'"drvReportCodeTwo"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ENFPPRUZ0','50','D','10','94',NULL,'94. Reporting Code 3',NULL,NULL,'"drvReportCodeThree"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ENFPPRUZ0','50','D','10','95',NULL,'95. Reporting Code 4',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ENFPPRUZ0','50','D','10','96',NULL,'96. Reporting Code 5',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ENFPPRUZ0','50','D','10','97',NULL,'97. Reporting Code 6',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ENFPPRUZ0','50','D','10','98',NULL,'98. Reporting Code 7',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ENFPPRUZ0','50','D','10','99',NULL,'99. Reporting Code 8',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ENFPPRUZ0','50','D','10','100',NULL,'100. Reporting Code 9',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ENFPPRUZ0','50','D','10','101',NULL,'101. Reporting Code 10',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ENFPPRUZ0','50','D','10','102',NULL,'102. Reporting Code 11',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ENFPPRUZ0','50','D','10','103',NULL,'103. Reporting Code 12',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ENFPPRUZ0','50','D','10','104',NULL,'104. Reporting Code 13',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ENFPPRUZ0','50','D','10','105',NULL,'105. Reporting Code 14',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ENFPPRUZ0','50','D','10','106',NULL,'106. Reporting Code 15',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ENFPPRUZ0','50','D','10','107',NULL,'107. Reporting Code 16',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ENFPPRUZ0','50','D','10','108',NULL,'108. Reporting Code 17',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ENFPPRUZ0','50','D','10','109',NULL,'109. Reporting Code 18',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','ENFPPRUZ0','50','D','10','110',NULL,'110. Reporting Code 19',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','ENFPPRUZ0','50','D','10','111',NULL,'111. Reporting Code 20',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','ENFPPRUZ0','50','D','10','112',NULL,'112. Contact 1 Type',NULL,NULL,'"ZT002"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','ENFPPRUZ0','50','D','10','113',NULL,'113. Contact 1 Last Name',NULL,NULL,'"Benefits"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','ENFPPRUZ0','50','D','10','114',NULL,'114. Contact 1 First Name',NULL,NULL,'"HR"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','ENFPPRUZ0','50','D','10','115',NULL,'115. Contact 1 Phone',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','ENFPPRUZ0','50','D','10','116',NULL,'116. Contact 1 Phone Extension',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','ENFPPRUZ0','50','D','10','117',NULL,'117. Contact 1 Email',NULL,NULL,'"corp-hrbenefits@federalsignal.com"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','ENFPPRUZ0','50','D','10','118',NULL,'118. Contact 1 ID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','ENFPPRUZ0','50','D','10','119',NULL,'119. Contact 1 SSN',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','ENFPPRUZ0','50','D','10','120',NULL,'120. Contact 2 Type',NULL,NULL,'"drvContactType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','ENFPPRUZ0','50','D','10','121',NULL,'121. Contact 2 Last Name',NULL,NULL,'"drvContactLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','ENFPPRUZ0','50','D','10','122',NULL,'122. Contact 2  First Name',NULL,NULL,'"drvContactFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','ENFPPRUZ0','50','D','10','123',NULL,'123. Contact 2 Phone',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','ENFPPRUZ0','50','D','10','124',NULL,'124. Contact 2 Phone Extension',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','ENFPPRUZ0','50','D','10','125',NULL,'125. Contact 2 Email',NULL,NULL,'"drvContactEmail"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','ENFPPRUZ0','50','D','10','126',NULL,'126. Contact 2 ID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','ENFPPRUZ0','50','D','10','127',NULL,'127. Contact 2 SSN',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','ENFPPRUZ0','50','D','10','128',NULL,'128. Contact 3 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','ENFPPRUZ0','50','D','10','129',NULL,'129. Contact 3 Last Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','ENFPPRUZ0','50','D','10','130',NULL,'130. Contact 3 First Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','ENFPPRUZ0','50','D','10','131',NULL,'131. Contact 3 Phone',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','ENFPPRUZ0','50','D','10','132',NULL,'132. Contact 3 Phone Extension',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','ENFPPRUZ0','50','D','10','133',NULL,'133. Contact 3 Email',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','ENFPPRUZ0','50','D','10','134',NULL,'134. Contact 3 ID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','ENFPPRUZ0','50','D','10','135',NULL,'135. Contact 3 SSN',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','ENFPPRUZ0','50','D','10','136',NULL,'136. Contact 4 Type',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','ENFPPRUZ0','50','D','10','137',NULL,'137. Contact 4 Last Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','ENFPPRUZ0','50','D','10','138',NULL,'138. Contact 4 First Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','ENFPPRUZ0','50','D','10','139',NULL,'139. Contact 4 Phone',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','ENFPPRUZ0','50','D','10','140',NULL,'140. Contact 4 Phone Extension',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','ENFPPRUZ0','50','D','10','141',NULL,'141. Contact 4 Email',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','ENFPPRUZ0','50','D','10','142',NULL,'142. Contact 4 ID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','ENFPPRUZ0','50','D','10','143',NULL,'143. Contact 4 SSN',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','ENFPPRUZ0','50','D','10','144',NULL,'144. Type of Employment',NULL,NULL,'"Z3999"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','ENFPPRUZ0','50','D','10','145',NULL,'145. Sector of Employment',NULL,NULL,'"Z2002"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','ENFPPRUZ0','20','D','10','146',NULL,'146. FMLA Branch Code',NULL,NULL,'"drvFMLABranchCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','ENFPPRUZ0','20','D','10','147',NULL,'147. FMLA Work Location Code',NULL,NULL,'"drvFMLAWorkLocCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','ENFPPRUZ0','20','D','10','148',NULL,'148. Key EE Indicator',NULL,NULL,'"drvFMLAKeyEEIndicator"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','ENFPPRUZ0','20','D','10','149',NULL,'149. Standard Work Schedule',NULL,NULL,'"drvStdWorkSch"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','ENFPPRUZ0','50','D','10','150',NULL,'150. Hours worked in last 12 months',NULL,NULL,'"drvTotHrs"','(''UNT2''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','ENFPPRUZ0','50','D','10','151',NULL,'151. Hours worked since last file',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','ENFPPRUZ0','20','D','10','152',NULL,'152. As of Date for Hours worked in last 12 Months',NULL,NULL,'"drvAnnHoursWorked"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','ENFPPRUZ0','20','D','10','153',NULL,'153. Adjusted Date of Hire',NULL,NULL,'"drvAdjHireDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','ENFPPRUZ0','50','D','10','154',NULL,'154. Shared Leave Relationship 1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','ENFPPRUZ0','50','D','10','155',NULL,'155. Shared Leave Relationship 1 SSN',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','ENFPPRUZ0','50','D','10','156',NULL,'156. Shared Leave Relationship 1 EE ID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','ENFPPRUZ0','50','D','10','157',NULL,'157. Shared Leave Relationship 1 Last Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','ENFPPRUZ0','50','D','10','158',NULL,'158. Shared Leave Relationship 1 First Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','ENFPPRUZ0','50','D','10','159',NULL,'159. Shared Leave Relationship 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','ENFPPRUZ0','50','D','10','160',NULL,'160. Shared Leave Relationship 2 SSN',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','ENFPPRUZ0','50','D','10','161',NULL,'161. Shared Leave Relationship 2 EE ID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','ENFPPRUZ0','50','D','10','162',NULL,'162. Shared Leave Relationship 2 Last Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','ENFPPRUZ0','50','D','10','163',NULL,'163. Shared Leave Relationship 2 First Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','ENFPPRUZ0','50','D','10','164',NULL,'164. Shared Leave Relationship 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','ENFPPRUZ0','50','D','10','165',NULL,'165. Shared Leave Relationship 3 SSN',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','ENFPPRUZ0','50','D','10','166',NULL,'166. Shared Leave Relationship 3 EE ID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','ENFPPRUZ0','50','D','10','167',NULL,'167. Shared Leave Relationship 3 Last Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','ENFPPRUZ0','50','D','10','168',NULL,'168. Shared Leave Relationship 3 First Name',NULL,NULL,'""','(''DA''=''T'')');

-----------
-- Build web filename
-----------

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME, 2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME, 3) ELSE LEFT(@@SERVERNAME, 2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME, 2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME, 3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FileName varchar(1000) = 'ENFPPRU_20230516.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',DO9RK,OM1S6,OM2JU,OM1N3,OM288,OM2M7,6QYTP,QITD4,DO9UW,DO9Y7,DOA25,DOA4N,OM2Q9',NULL,NULL,NULL,'NFP Federal Signal ONDEMAND','201910319','EMPEXPORT','ONDEMAND',NULL,'ENFPPRU',NULL,NULL,NULL,'201910319','Oct 31 2019  3:43PM','Oct 31 2019  3:43PM','201910311',NULL,'','','201910311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','HAWZ4,ZMCX7,OM2CX,OM2BQ,OM1S6,OM2RX,OM2PG,OM2JU,OM1N3,OM2OA,F5634,OM288,OM2M7,6QYTP,OM29Z,QITD4,OM28J,OM2LK,OM267,9NIOW,Q3SLM,ZMD1D,ZMD2C,6ZPEX,ZMD3G,ZMD48,B4XO2,ZMD5U,ZMD73,ZMD8R,ZMD9Y,OM2Q9,7RZG6,OM2GD',NULL,NULL,NULL,'NFP Federal Signal SCHEDULED','202211089','EMPEXPORT','SCHED_NFPR','Nov  8 2022 12:00AM','ENFPPRU',NULL,NULL,NULL,'202305169','Nov  8 2022 12:00AM','Dec 30 1899 12:00AM','202305091','2121','','','202211011',dbo.fn_GetTimedKey(),NULL,'AGUMBHIR01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',DO9RK,45RGD,OM1S6,OM2JU,OM1N3,W87J2,OM288,5A4AA,OM2M7,6QYTP,QITD4,ZH8Z8,DO9UW,DO9Y7,DOA25,DOA4N,OM2Q9,OM2GD',NULL,NULL,NULL,'NFP Federal Signal TEST','202305169','EMPEXPORT','TEST','May 11 2021 12:00AM','ENFPPRU',NULL,NULL,NULL,'202305169','May 11 2021 12:00AM','Dec 30 1899 12:00AM','202305091',NULL,'','','202305091',dbo.fn_GetTimedKey(),NULL,'ULTI_FSCORP',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENFPPRU','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENFPPRU','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENFPPRU','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENFPPRU','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENFPPRU','UDESPath','C','\\N1SUP2DB54\UltiProData\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENFPPRU','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENFPPRU','H01','dbo.U_ENFPPRU_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENFPPRU','D10','dbo.U_ENFPPRU_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ENFPPRU_cmpTbl
-----------

IF OBJECT_ID('U_ENFPPRU_cmpTbl') IS NULL
CREATE TABLE [dbo].[U_ENFPPRU_cmpTbl] (
    [drvCoID] char(5) NULL,
    [drvCompanyCode1] char(5) NULL,
    [drvCompanyName1] varchar(40) NULL,
    [drvCmpAddressLine1] varchar(30) NULL,
    [drvCmpAddressLine2] varchar(30) NULL,
    [drvCompanyCity] varchar(30) NULL,
    [drvCompanyState] char(2) NULL,
    [drvCompanyZip] char(10) NULL
);

-----------
-- Create table U_ENFPPRU_DedList
-----------

IF OBJECT_ID('U_ENFPPRU_DedList') IS NULL
CREATE TABLE [dbo].[U_ENFPPRU_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ENFPPRU_drvTbl
-----------

IF OBJECT_ID('U_ENFPPRU_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENFPPRU_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvEmpNo] varchar(9) NULL,
    [drvSSN] varchar(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvOriginalHire] datetime NULL,
    [drvLastHire] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvTermDate] datetime NULL,
    [drvBirthDate] datetime NULL,
    [drvContactEmail] varchar(22) NULL,
    [drvContactLastName] varchar(2) NULL,
    [drvContactFirstName] varchar(2) NULL,
    [drvContactType] varchar(5) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(5) NULL,
    [drvCity] varchar(255) NULL,
    [drvGender] varchar(1) NULL,
    [drvMaritalStatus] varchar(5) NULL,
    [drvJobTitle] varchar(6000) NULL,
    [drvEmplStatus] varchar(1) NULL,
    [drvAnnSalary] varchar(40) NULL,
    [drvDedBenCode] varchar(5) NULL,
    [drvBenStartDate] datetime NULL,
    [drvStatBranchCode] varchar(5) NULL,
    [drvStatCovType] varchar(3) NULL,
    [drvStatEffDate] datetime NULL,
    [drvLTDBranchCore] varchar(5) NULL,
    [drvLTDCovEffDate] datetime NULL,
    [drvLTDBranchCodeBuyUp] varchar(5) NULL,
    [drvLTDCovEffDateBuyUp] datetime NULL,
    [drvReportCode] varchar(6) NULL,
    [drvReportCodeTwo] varchar(5) NULL,
    [drvReportCodeThree] varchar(1) NOT NULL,
    [drvFMLABranchCode] varchar(5) NULL,
    [drvFMLAWorkLocCode] varchar(4) NULL,
    [drvFMLAKeyEEIndicator] varchar(1) NULL,
    [drvStdWorkSch] varchar(1) NULL,
    [drvAnnHoursWorked] datetime NULL,
    [drvAdjHireDate] datetime NULL,
    [drvCountry] varchar(2) NULL,
    [drvTotHrs] decimal NULL,
    [drvEmail] varchar(50) NULL,
    [drvCompanyCode] varchar(5) NULL
);

-----------
-- Create table U_ENFPPRU_EEList
-----------

IF OBJECT_ID('U_ENFPPRU_EEList') IS NULL
CREATE TABLE [dbo].[U_ENFPPRU_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ENFPPRU_EmpDed
-----------

IF OBJECT_ID('U_ENFPPRU_EmpDed') IS NULL
CREATE TABLE [dbo].[U_ENFPPRU_EmpDed] (
    [EedEEID] char(12) NOT NULL,
    [EedCOID] char(5) NOT NULL,
    [EedDedCode] char(5) NULL,
    [EedBenStartDate] datetime NULL,
    [EedLtdBranch] varchar(5) NULL,
    [EedBenStopDate] datetime NULL,
    [EedLTDEffDate] datetime NULL,
    [EedLTDBranchCodeBuyUp] varchar(1) NOT NULL,
    [EedLTDCovEffDateBuyUp] datetime NULL
);

-----------
-- Create table U_ENFPPRU_File
-----------

IF OBJECT_ID('U_ENFPPRU_File') IS NULL
CREATE TABLE [dbo].[U_ENFPPRU_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_ENFPPRU_Header
-----------

IF OBJECT_ID('U_ENFPPRU_Header') IS NULL
CREATE TABLE [dbo].[U_ENFPPRU_Header] (
    [drvCountRFRows] int NULL,
    [drvCurrentDate] datetime NOT NULL
);

-----------
-- Create table U_ENFPPRU_PDedHist
-----------

IF OBJECT_ID('U_ENFPPRU_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENFPPRU_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);

-----------
-- Create table U_ENFPPRU_Prg
-----------

IF OBJECT_ID('U_ENFPPRU_Prg') IS NULL
CREATE TABLE [dbo].[U_ENFPPRU_Prg] (
    [PrgEEID] char(12) NOT NULL,
    [PrgTotHours] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENFPPRU]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: NFP Federal Signal


Create Date: 01/30/2020
Service Request Number: SR-2019-00254805

Purpose: NFP Federal Signal ELIGIBILITY FILE

Revision History
----------------
Update By           Date           Request Num            Desc
Sean Hawkins        04/15/2021     SR-2021-00307278        Updates for spec 1.04 - TEST only at this point
Sean Hawkins        05/12/2021                             Updates now for prod

Marie Waters        04/13/2023      TekP-2022-11-10-06      Updated code for LTD in test
Marie Waters        04/17/2023      TekP-2022-11-10-06      Updated code for STD in test
Marie Waters        05/16/2023      TekP-2022-11-10-06      Updated from test to prod

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENFPPRU';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENFPPRU';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENFPPRU';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENFPPRU';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENFPPRU' ORDER BY RunID DESC;

select cmpcompanycode, cmpcompanyname, eecpaygroup, eecdedgroupcode from empcomp join company on cmpcoid = eeccoid where cmpcompanycode = 'MRL'
select filCreateDate, filFileName, filFilePath,* 
from dbo.FileInfo
where filFileName like '%ENFPPRU%'
order by 1 desc 


Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENFPPRU', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENFPPRU', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENFPPRU', 'SCHED_NFPR';

EXEC dbo._dsi_usp_ExportRipOut_v7 @FormatCode = 'ENFPPRU', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'ENFPPRU';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ENFPPRU_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENFPPRU_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -------------------------------
    ---- Working Table - U_ENFPPRU_EmpDed
    -------------------------------
    --    IF OBJECT_ID('U_ENFPPRU_EmpDed','U') IS NOT NULL
    --    DROP TABLE dbo.U_ENFPPRU_EmpDed;
    --SELECT DISTINCT
    --     EedEEID
    --     ,EedCOID
    --     ,EedDedCode = MAX(EedDedCode)
    --     ,EedBenStartDate = MAX(EedBenStartDate)
    --     ,EedLtdBranch =  MAX(CASE 
    --                            WHEN EedDedCode IN ('LTDR') AND EedBenStopDate IS NULL THEN '00001'
    --                            WHEN EedDedCode IN ('LTDMR') AND EedBenStopDate IS NULL THEN '00007'
    --                            WHEN EedDedCode IN ('LTDTX') AND EedBenStopDate IS NULL THEN '00006'   --Adding the TBEI employees' Branch code to the LTD Code
    --                            WHEN EedDedCode IN ('LTDTN') AND EedBenStopDate IS NULL THEN  '00007'  --Adding the TBEI employees' Branch code to the LTD Code 
    --                            ELSE NULL
    --                           END)
    --     --,EedBenSTD = MAX(CASE 
    --     --                       WHEN EedDedCode IN ('ADD','ADDI') AND EedBenStopDate IS NULL THEN '00001' 
    --     --                       WHEN EedDedCode IN ('STDTN') AND EedBenStopDate IS NULL THEN '00008'     --Adding the TBEI employees' Branch code to the STD Code
    --     --                       WHEN EedDedCode IN ('STDTX') AND EedBenStopDate IS NULL THEN '00007'     --Adding the TBEI employees' Branch code to the LTD Code
    --     --                       ELSE NULL 
    --     --                       END)
    --     ,EedBenStopDate = MAX(EedBenStopDate)
    --     ,EedLTDEffDate = MAX(CASE WHEN EedDedCode IN ('LTDR','LTDMR','LTDTN','LTDTX') AND EedBenStopDate IS NULL THEN EedBenStartDate ELSE NULL END) --Adding the TBEI employees' LTD Code
    --     ,EedLTDBranchCodeBuyUp = ''
    --     --MAX(CASE WHEN EedDedCode IN ('LTDV') AND EedBenStopDate IS NULL THEN 'A0001' ELSE NULL END)
    --     ,EedLTDCovEffDateBuyUp =  MAX(CASE WHEN EedDedCode IN ('LTDV') AND EedBenStopDate IS NULL THEN EedBenStartDate ELSE NULL END)
         
    --INTO dbo.U_ENFPPRU_EmpDed
    --FROM dbo.EmpDed WITH (NOLOCK)
    --WHERE EedBenStatus IN ('A')
    --GROUP BY EedEEID,EedCOID   

    -----------------------------
    -- Working Table - U_ENFPPRU_Prg
    -----------------------------
    IF OBJECT_ID('U_ENFPPRU_Prg','U') IS NOT NULL
        DROP TABLE dbo.U_ENFPPRU_Prg;
    SELECT DISTINCT
         PrgEEID
        ,PrgTotHours = SUM(PrgTotHours)
    INTO dbo.U_ENFPPRU_Prg
    FROM dbo.PayReg WITH (NOLOCK)
    WHERE CONVERT(DATE, Substring(PrgPerControl,1,8), 112) > DATEADD(day, -365, GETDATE())
    GROUP BY PrgEEID
    HAVING (SUM(PrgTotHours) <> 0.00);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENFPPRU_drvTbl

    ---------------------------------
    IF OBJECT_ID('U_ENFPPRU_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENFPPRU_drvTbl;
   SELECT DISTINCT
        drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvEmpNo =              RTRIM(EecEmpNo)
        ,drvSSN =                RTRIM(eepSSN)
        ,drvNameLast =           RTRIM(EepNameLast)
        ,drvNameFirst =          RTRIM(EepNameFirst)
        ,drvOriginalHire =       EecDateOfOriginalHire
        ,drvLastHire =           EecDateOfLastHire
        ,drvAddressLine1 =       RTRIM(EepAddressLine1)
        ,drvAddressLine2 =       RTRIM(EepAddressLine2)
        ,drvTermDate =           EecDateOfTermination
        ,drvBirthDate =          EepDateOfBirth
        ,drvContactEmail=        CASE 
                                    WHEN CmpCompanyCode='SIGNL' AND CmpAddressCity='University Park' THEN 'UPHR@federalsignal.com'
                                    ELSE NULL
                                END
        ,drvContactLastName =   CASE 
                                    WHEN CmpCompanyCode='SIGNL' AND CmpAddressCity='University Park' THEN 'HR'
                                    ELSE NULL
                                END        
        ,drvContactFirstName =   CASE 
                                    WHEN CmpCompanyCode='SIGNL' AND CmpAddressCity='University Park' THEN 'UP'
                                    ELSE NULL
                                END
        ,drvContactType =   CASE 
                                    WHEN CmpCompanyCode='SIGNL' AND CmpAddressCity='University Park' THEN 'ZT003'
                                    ELSE NULL
                                END
        ,drvState =              RTRIM(EepAddressState)
        ,drvZipCode=             RTRIM(SUBSTRING(EepAddressZipCode,1,5))
        ,drvCity=                RTRIM(EepAddressCity)
        ,drvGender =             RTRIM(EepGender) 
        ,drvMaritalStatus=       CASE WHEN EepMaritalStatus = 'S' THEN '04001' 
                                      WHEN EepMaritalStatus = 'M' THEN '04002' 
                                      WHEN EepMaritalStatus = 'W' THEN '04003'
                                      WHEN EepMaritalStatus = 'D' THEN '04004'
                                      ELSE NULL
                                 END
        ,drvJobTitle=            RTRIM(dbo.dsi_fnRemoveChars(',/^',JbcDesc))  --LTRIM(RTRIM(jbcDesc))
        ,drvEmplStatus=          RTRIM(EecEmplStatus)
        ,drvAnnSalary=           RTRIM(EecAnnSalary)
        ,drvDedBenCode=          CASE WHEN STDTX is not null then STDTX 
                                        WHEN STDTN is not null then STDTN 
                                        WHEN STDMR IS NOT NULL THEN STDMR
                                        WHEN STD IS NOT NULL THEN STD
                                        END
                            --CASE WHEN STDTXDedcode = 'STDTX' THEN '00007'
       --                                 WHEN STDTNDedcode = 'STDTN' AND EecSalaryOrHourly = 'S' THEN '00008'
                            --            --WHEN CmpCompanyCode in ('CRYST', 'OXBOD', 'RUGBY', 'TISHO', 'TRAV') AND EecSalaryOrHourly = 'S' THEN '00008'
       --                                 WHEN STDTNDedcode = 'STDTN' AND EecSalaryOrHourly = 'H' THEN '00009'
                            --            --WHEN CmpCompanyCode in ('CRYST', 'OXBOD', 'RUGBY', 'TISHO', 'TRAV') AND EecSalaryOrHourly = 'H' THEN '00009'
       --                                 WHEN (STDMRDedcode = 'STDMR' or CmpCompanyCode = 'MRL') AND EecSalaryOrHourly = 'S' THEN '00012'
       --                                 WHEN (STDMRDedcode = 'STDMR' or CmpCompanyCode = 'MRL') AND EecSalaryOrHourly = 'H' THEN '00011'
                            --            WHEN STDDedcode not IN ('STDTX','STDTN','STDMR') and CmpCompanyCode not in ('MRL','TBEI', 'CRYST', 'OXBOD', 'RUGBY', 'TISHO', 'TRAV') and EecUnionLocal IS NOT NULL THEN '00006' 
                                        
                            --            WHEN STDDedcode not IN ('STDTX','STDTN','STDMR') and CmpCompanyCode not in ('MRL','TBEI', 'CRYST', 'OXBOD', 'RUGBY', 'TISHO', 'TRAV') and EecUnionLocal IS NULL 
       --                                 THEN CASE 
       --                                 WHEN EecDateOfLastHire >= DATEADD(YEAR, -5, GETDATE()) AND eecSalaryOrHourly = 'H' THEN '00001'
       --                                 WHEN EecDateOfLastHire < DATEADD(YEAR, -5, GETDATE()) AND eecSalaryOrHourly = 'H' THEN '00002'
       --                                 WHEN EecDateOfLastHire >= DATEADD(YEAR, -1, GETDATE()) AND eecSalaryOrHourly = 'S' THEN '00003'
       --                                 WHEN (EecDateOfLastHire BETWEEN  DATEADD(YEAR, -5, GETDATE()) AND  DATEADD(YEAR, -1, GETDATE())) AND eecSalaryOrHourly = 'S' THEN '00004'
       --                                 WHEN EecDateOfLastHire < DATEADD(YEAR, -5, GETDATE()) AND eecSalaryOrHourly = 'S' THEN '00005'
       --                                 END
       --                             END
        
                                --CASE WHEN EecUnionLocal IS NOT NULL THEN '00006'   ---STD Branch Codes
        --                         WHEN EecUnionLocal IS NULL 
        --                            THEN CASE 
        --                                WHEN EecDateOfLastHire >= DATEADD(YEAR, -5, GETDATE()) AND eecSalaryOrHourly = 'H' THEN '00001'
        --                                WHEN EecDateOfLastHire < DATEADD(YEAR, -5, GETDATE()) AND eecSalaryOrHourly = 'H' THEN '00002'
        --                                WHEN EecDateOfLastHire >= DATEADD(YEAR, -1, GETDATE()) AND eecSalaryOrHourly = 'S' THEN '00003'
        --                                WHEN (EecDateOfLastHire BETWEEN  DATEADD(YEAR, -5, GETDATE()) AND  DATEADD(YEAR, -1, GETDATE())) AND eecSalaryOrHourly = 'S' THEN '00004'
        --                                WHEN EecDateOfLastHire < DATEADD(YEAR, -5, GETDATE()) AND eecSalaryOrHourly = 'S' THEN '00005'
        --                             END
        --                        END
        ,drvBenStartDate =   CASE WHEN STDDedcode IN ('STDTX','STDTN','STDMR') THEN STDBenStartDate ELSE EecDateOfLastHire END                                     
        
        
                                    ---EedBenStartDate    --STD Eff date
                                    
        ,drvStatBranchCode=      CASE WHEN EecWCState IN ('NY','NJ') THEN '00001' ELSE NULL END
        ,drvStatCovType=         CASE WHEN EecWCState='NY' THEN 'DBL' 
                                      WHEN EecWCState='NJ' THEN 'TDB'
                                      WHEN EecWCState='HI' THEN 'TDI'
                                    
                                 END
        ,drvStatEffDate=        CASE
                                    WHEN EecWCState IN ('NY','NJ') THEN EecDateOfLastHire
                                   
                                END
                                
        ,drvLTDBranchCore =    CASE WHEN LTDR is not null then LTDR 
                                    WHEN LTDTN is not null then LTDTN
                                    WHEn LTDMR is not null then LTDMR
                                    When LTDTX is not null then LTDTX 
                                    end
        ,drvLTDCovEffDate= CASE WHEN LTDR is not null then LTDRBenstartDate 
                                    WHEN LTDTN is not null then LTDTNBenstartDate
                                    WHEn LTDMR is not null then LTDMRBenstartDate
                                    When LTDTX is not null then LTDTXBenstartDate 
                                    end
                                    --CASE WHEN LTDDedcode IN ('LTDR','LTDMR','LTDTN','LTDTX') THEN LTDBenStartDate END
        ,drvLTDBranchCodeBuyUp=    CASE WHEN CmpCompanyCode <>   'MRL' THEN CASE
                                        WHEN  LTDVDedcode = 'LTDV' and eecSalaryOrHourly = 'S'THEN 'A0001'--updated 5/6/2021 - one less zero value
                                        WHEN  LTDVDedcode = 'LTDV' and eecSalaryOrHourly = 'H' THEN 'A0002'--updated 5/6/2021 - one less zero value
                                  END
                                  END
                                --EedLTDBranchCodeBuyUp
        ,drvLTDCovEffDateBuyUp=  Case when LTDVDedcode = 'LTDV' THEN LTDVBenStartDate END
        ,drvReportCode=           RTRIM(EecPayGroup)--Keep as paygroup, not changing here after all
        ,drvReportCodeTwo =          RTRIM(EecDedGroupCode)--CASE WHEN @ExportCode = 'TEST' then RTRIM(EecDedGroupCode) else '' end--new 4/12/2021 per call - field 93 in layout
        ,drvReportCodeThree =      ''--removed 5/4/2021 - CASE WHEN @ExportCode = 'TEST' THEN RTRIM(EecLocation) else '' end--new 4/22/2021 - possible update for field 94, send as test

        ,drvFMLABranchCode=       CASE 
                                    WHEN CmpCompanyCode='MRL' THEN NULL
                                    WHEN CmpCompanyCode='SIGNL' AND CmpAddressCity='University Park' THEN '00003'
                                    WHEN CmpCompanyCode IN ('CRYST', 'OXBOD', 'RUGBY', 'TISHO', 'TRAV') THEN '00002' --Adding the TBEI employees' Branch code to the FMLA Code
                                    ELSE ('00001')
                                  END
        ,drvFMLAWorkLocCode=    CASE 
                                    WHEN CmpCompanyCode='MRL' THEN NULL
                                    WHEN CmpCompanyCode IN ('CRYST', 'OXBOD', 'RUGBY', 'TISHO', 'TRAV') THEN 'TBEI' --Adding the TBEI employees' Location code to the FMLA Code
                                    ELSE ('FSC')
                                END
        ,drvFMLAKeyEEIndicator= CASE 
                                    WHEN CmpCompanyCode='MRL' THEN NULL
                                    ELSE ('N')
                                END
        ,drvStdWorkSch=            CASE 
                                    WHEN CmpCompanyCode='MRL' THEN NULL
                                    ELSE ('N')
                                END
        ,drvAnnHoursWorked=        CASE 
                                    WHEN CmpCompanyCode='MRL' THEN NULL
                                    ELSE getdate()
                                END
        ,drvAdjHireDate=        CASE 
                                    WHEN CmpCompanyCode='MRL' THEN NULL
                                    ELSE EecDateOfLastHire
                                END
        ,drvCountry =            Substring(RTRIM(EepAddressCountry),1,2)
        ,drvTotHrs  =            CASE 
                                    WHEN CmpCompanyCode='MRL' THEN NULL 
                                    ELSE PrgTotHours
                                END
        ,drvEmail = RTRIM(EepAddressEMail)
        ,drvCompanyCode = RTRIM(CmpCompanyCode)
     
    INTO dbo.U_ENFPPRU_drvTbl
    FROM dbo.U_ENFPPRU_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN JobCode WITH(NOLOCK)                  
    ON eecJobCode = JobCode.jbcJobCode
    JOIN dbo.Company WITH(NOLOCK)
        ON CmpCOID = xCOID
   JOIN (
        Select Distinct    
          EedEEID
         ,EedCOID    
         ,LTDR = MAX(CASE WHEN EedDedcode = 'LTDR'THEN
                        CASE WHEN  EecSalaryOrHourly = 'S' and EedBenStopDate IS NULL THEN '00001' 
                          WHEN EecSalaryOrHourly = 'H' and EedBenStopDate IS NULL THEN '00003' END
                         END)
        ,LTDRDedCode  = MAX(CASE WHEN EedDedcode = 'LTDR'THEN EedDedcode END)        
        ,LTDRBenstartDate  = MAX(CASE WHEN EedDedcode = 'LTDR'THEN EedBenStartDate END)
        ,LTDRBenstopDate  = MAX(CASE WHEN EedDedcode = 'LTDR'THEN EedBenStopDate END)
        ,LTDTN = MAX(CASE WHEN EedDedcode = 'LTDTN' THEN
                            CASE WHEN  EecSalaryOrHourly = 'S' and EedBenStopDate IS NULL THEN '00007' 
                          WHEN EecSalaryOrHourly = 'H' and EedBenStopDate IS NULL THEN '00008' END
                         END)
        ,LTDTNDedCode  = MAX(CASE WHEN EedDedcode = 'LTDTN'THEN EedDedcode END)        
        ,LTDTNBenstartDate  = MAX(CASE WHEN EedDedcode = 'LTDTN'THEN EedBenStartDate END)
        ,LTDTNBenstopDate  = MAX(CASE WHEN EedDedcode = 'LTDTN'THEN EedBenStopDate END)
        ,LTDMR    = MAX(CASE WHEN EedDedcode = 'LTDMR' AND EedBenStopDate IS NULL THEN '00012' END)
        ,LTDMRDedCode  = MAX(CASE WHEN EedDedcode = 'LTDMR'THEN EedDedcode END)        
        ,LTDMRBenstartDate  = MAX(CASE WHEN EedDedcode = 'LTDMR'THEN EedBenStartDate END)
        ,LTDMRBenstopDate  = MAX(CASE WHEN EedDedcode = 'LTDMR'THEN EedBenStopDate END)
        ,LTDTX = MAX(CASE WHEN EedDedcode = 'LTDTX' AND EedBenStopDate IS NULL THEN '00006' END )
        ,LTDTXDedCode  = MAX(CASE WHEN EedDedcode = 'LTDTX'THEN EedDedcode END)        
        ,LTDTXBenstartDate  = MAX(CASE WHEN EedDedcode = 'LTDTX'THEN EedBenStartDate END)
        ,LTDTXBenstopDate  = MAX(CASE WHEN EedDedcode = 'LTDTX'THEN EedBenStopDate END)
        ,LTDVDedCode  = MAX(CASE WHEN EedDedcode = 'LTDV'THEN EedDedcode END)        
        ,LTDVBenstartDate  = MAX(CASE WHEN EedDedcode = 'LTDV'THEN EedBenStartDate END)
        ,LTDVBenstopDate  = MAX(CASE WHEN EedDedcode = 'LTDV'THEN EedBenStopDate END)
        ,STDTX = MAX(CASE WHEN EedDedcode = 'STDTX' THEN '00007' END)        
        ,STDTXDedCode  = MAX(CASE WHEN EedDedcode = 'STDTX'THEN EedDedcode END)        
        ,STDTXBenstartDate  = MAX(CASE WHEN EedDedcode = 'STDTX'THEN EedBenStartDate END)
        ,STDTXBenstopDate  = MAX(CASE WHEN EedDedcode = 'STDTX'THEN EedBenStopDate END)
        ,STDTNDedCode  = MAX(CASE WHEN EedDedcode = 'STDTN' THEN EedDedcode END)    
        ,STDTN = MAX(CASE WHEN (EedDedcode = 'STDTN' OR CmpCompanyCode in ('CRYST', 'OXBOD', 'RUGBY', 'TISHO', 'TRAV')) THEN
                            CASE WHEN EecSalaryOrHourly = 'S'  THEN '00008' 
                          WHEN EecSalaryOrHourly = 'H' THEN '00009' END
                         END)
        ,STDTNBenstartDate  = MAX(CASE WHEN EedDedcode = 'STDTN'THEN EedStartDate END)
        ,STDTNBenstopDate  = MAX(CASE WHEN EedDedcode = 'STDTN'THEN EedBenStopDate END)
        ,STDMRDedCode  = MAX(CASE WHEN EedDedcode = 'STDMR'THEN EedDedcode END)    
        ,STDMR = MAX(CASE WHEN (EedDedcode = 'STDMR' or CmpCompanyCode = 'MRL') THEN
                                    CASE WHEN EecSalaryOrHourly = 'S' THEN '00012'
                                         WHEN EecSalaryOrHourly = 'H' THEN '00011' END
                                        END)
        ,STDMRBenstartDate  = MAX(CASE WHEN EedDedcode = 'STDMR'THEN EedBenStartDate END)
        ,STDMRBenstopDate  = MAX(CASE WHEN EedDedcode = 'STDMR'THEN EedBenStopDate END)

        ,STD = MAX(CASE WHEN EedDedcode not IN ('STDTX','STDTN','STDMR') THEN 
                                    CASE WHEN EecUnionLocal IS NOT NULL THEN '00006' 
                                    WHEN EecUnionLocal IS NULL THEN
                                                CASE 
                                                    WHEN EecDateOfLastHire >= DATEADD(YEAR, -5, GETDATE()) AND eecSalaryOrHourly = 'H' THEN '00001'
                                                    WHEN EecDateOfLastHire < DATEADD(YEAR, -5, GETDATE()) AND eecSalaryOrHourly = 'H' THEN '00002'
                                                    WHEN EecDateOfLastHire >= DATEADD(YEAR, -1, GETDATE()) AND eecSalaryOrHourly = 'S' THEN '00003'
                                                    WHEN (EecDateOfLastHire BETWEEN DATEADD(YEAR, -5, GETDATE()) AND DATEADD(YEAR, -1, GETDATE())) AND eecSalaryOrHourly = 'S' THEN '00004'
                                                    WHEN EecDateOfLastHire < DATEADD(YEAR, -5, GETDATE()) AND eecSalaryOrHourly = 'S' THEN '00005'
                                                    END
                                                END

                                    END)
        ,STDDedCode  = MAX(CASE WHEN EedDedcode IN ('STDTX','STDTN','STDMR') THEN EedDedcode END)        
        ,STDBenstartDate  = MAX(CASE WHEN EedDedcode IN ('STDTX','STDTN','STDMR') THEN EedBenStartDate END)
        ,STDBenstopDate  = MAX(CASE WHEN EedDedcode IN ('STDTX','STDTN','STDMR')  THEN EedBenStopDate END)
        ,LTDDedCode  = MAX(CASE WHEN EedDedcode IN ('LTDR','LTDMR','LTDTN','LTDTX') THEN EedDedcode END)        
        ,LTDBenstartDate  = MAX(CASE WHEN EedDedcode IN ('LTDR','LTDMR','LTDTN','LTDTX') THEN EedBenStartDate END)
        ,LTDBenstopDate  = MAX(CASE WHEN EedDedcode IN ('LTDR','LTDMR','LTDTN','LTDTX')  THEN EedBenStopDate END)
      FROM dbo.EmpDed WITH (NOLOCK)
       JOIN dbo.EmpComp WITH (NOLOCK)
             ON EecEEID = EedEEID
            AND EecCoID = EedCOID
          JOIN dbo.Company WITH(NOLOCK)
        ON CmpCOID = EecCoID
            where EedDedcode IN ('LTDR','LTDMR','LTDTN','LTDTX','LTDV','STDTX','STDTN','STDMR')  
            and EedBenStatus NOT IN ('W', 'C')
            Group By Eedeeid, EedCoid) Ed
     ON eedEEID = XEEID
    and eedCoid  = XCOID

     --LEFT JOIN dbo.U_ENFPPRU_EmpDed WITH(NOLOCK)--changed to left join 5/7/2021 --MW Replaced with code above 5/16/2023
    --    ON EedEEID = xEEID
    --    AND EedCOID = xCOID
    JOIN dbo.U_ENFPPRU_Prg WITH(NOLOCK)--changed to left join 5/7/2021
        ON prgEEID  = xEEID
    WHERE (EecDateOfTermination >= DATEADD(day, -30, GETDATE()) OR EecEmplStatus in ('A','L')) 
   -- AND CmpCompanyCode in ('ELGIN', 'FSC', 'SIGNL', 'GUZLR', 'JTSTM', 'JJE', 'MRL', 'VACTR', 'VICTR')    -- Removed company filter per client request - 12/16/2022
    AND EepAddressCountry in ('USA')
    
   ;
    ---------------------------------
    -- RF HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ENFPPRU_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ENFPPRU_Header;
    SELECT DISTINCT
         drvCountRFRows =   (SELECT COUNT(*) FROM dbo.U_ENFPPRU_drvTbl WITH (NOLOCK))
        ,drvCurrentDate = getdate()
    INTO dbo.U_ENFPPRU_Header 
    ;

  
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_59963_DCMS_EligFile_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN '59963_DCMS_EligFile_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN '59963_DCMS_EligFile_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE '59963_DCMS_EligFile_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwENFPPRU_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENFPPRU_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2);

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ENFPPRU%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202305091'
       ,expStartPerControl     = '202305091'
       ,expLastEndPerControl   = '202305169'
       ,expEndPerControl       = '202305169'
WHERE expFormatCode = 'ENFPPRU' and expexportcode = 'TEST';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENFPPRU_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENFPPRU_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2)

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ENFPPRU' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ENFPPRU'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ENFPPRU'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENFPPRU', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ENFPPRU', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENFPPRU', 'UseFileName', 'V', 'Y'


-- End ripout