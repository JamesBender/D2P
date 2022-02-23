SET NOCOUNT ON;
IF OBJECT_ID('U_ECARE2OM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECARE2OM_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECARE2OM_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECARE2OM' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECARE2OM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECARE2OM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECARE2OM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECARE2OM];
GO
IF OBJECT_ID('U_ECARE2OM_File') IS NOT NULL DROP TABLE [dbo].[U_ECARE2OM_File];
GO
IF OBJECT_ID('U_ECARE2OM_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECARE2OM_EEList];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_ECARE2OM_Trailer') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_ECARE2OM_Trailer];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_ECARE2OM_Header') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_ECARE2OM_Header];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_ECARE2OM') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_ECARE2OM];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECARE2OM';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECARE2OM';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECARE2OM';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECARE2OM';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECARE2OM';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','ECARE2OM','Care.com Export V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_SwitchBox_v2','500','S','N','ECARE2OMZ0','N',NULL,'C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HEADER RECORD"','1','(''DA''=''T,'')','ECARE2OMZ0','24','H','01','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileName"','2','(''UA''=''T,'')','ECARE2OMZ0','80','H','01','2','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OGLETREE"','3','(''DA''=''T,'')','ECARE2OMZ0','10','H','01','3','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateTime"','4','(''UA''=''T'')','ECARE2OMZ0','14','H','01','4','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUEID"','1','(''UA''=''T,'')','ECARE2OMZ0','40','D','10','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','2','(''UA''=''T,'')','ECARE2OMZ0','45','D','10','2','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','3','(''UA''=''T,'')','ECARE2OMZ0','45','D','10','3','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRAILER RECORD"','1','(''DA''=''T,'')','ECARE2OMZ0','24','T','90','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecCnt"','2','(''UA''=''T,'')','ECARE2OMZ0','10','T','90','2','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTENTS OF THIS FILE ARE CONFIDENTIAL AND PROPRIETARY TO CARE.COM INC. AND OGLETREE"','3','(''DA''=''T'')','ECARE2OMZ0','100','T','90','3','','',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECARE2OM_20200312.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Export Session','202003121','EMPEXPORT','TEST','Mar 12 2020  2:49PM','ECARE2OM',NULL,NULL,NULL,'202003121','Mar 12 2020 12:00AM','Dec 30 1899 12:00AM','202003121','831','','','202003121',dbo.fn_GetTimedKey(),NULL,'CPETITTI03',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECARE2OM_20200312.txt' END WHERE expFormatCode = 'ECARE2OM';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECARE2OM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECARE2OM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECARE2OM','InitialSort','C','DrvUEID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECARE2OM','OnDemandPath','V','\\us.saas\e1\Public\OGL1000\Exports\Care.com\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECARE2OM','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECARE2OM','TestPath','V','\\us.saas\e1\Public\OGL1000\Exports\Care.com\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECARE2OM','UDESPath','C','\\us.saas\e0\data_exchange\OGL1000\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECARE2OM','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECARE2OM' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECARE2OM' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECARE2OM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECARE2OM_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECARE2OM','H01','dbo.U_Dsi_DrvTbl_ECARE2OM_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECARE2OM','D10','dbo.U_Dsi_DrvTbl_ECARE2OM',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECARE2OM','T90','dbo.U_Dsi_DrvTbl_ECARE2OM_Trailer',NULL);
IF OBJECT_ID('U_Dsi_DrvTbl_ECARE2OM') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_ECARE2OM] (
    [DrvUEID] char(9) NULL,
    [DrvFirstName] varchar(100) NULL,
    [DrvLastName] varchar(100) NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_ECARE2OM_Header') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_ECARE2OM_Header] (
    [DrvFileName] char(80) NULL,
    [DrvDateTime] char(14) NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_ECARE2OM_Trailer') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_ECARE2OM_Trailer] (
    [DrvRecCnt] int NULL
);
IF OBJECT_ID('U_ECARE2OM_EEList') IS NULL
CREATE TABLE [dbo].[U_ECARE2OM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECARE2OM_File') IS NULL
CREATE TABLE [dbo].[U_ECARE2OM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(500) NULL
);
GO
CREATE PROCEDURE[dbo].[dsi_sp_BuildDriverTables_ECARE2OM]
@SystemID VARCHAR(15) = NULL

AS

/************************************************************

Created By: Megan Cummings
Business Analyst: Bridget Amsden 
Create Date: 04/06/2018
ChangePoint Request Number: SR-2018-00186273

Purpose: To supply Vendor with Employee information.
Execute Export: dsi_sp_testswitchbox_v2 'ECARE2OM', 'ON_DEMAND'

Revision History
-----------------
Update By   Date   CP Num   Desc
XXXX    XX/XX/10  12345   Added DedCode 1234

SELECT * FROM U_Dsi_Configuration WHERE FormatCode = 'ECARE2OM'
SELECT * FROM U_Dsi_Parameters WHERE FormatCode = 'ECARE2OM'
SELECT * FROM U_Dsi_SqlClauses WHERE FormatCode = 'ECARE2OM'
SELECT * FROM U_DSI_InterfaceActivityLog WHERE FormatCode = 'ECARE2OM' ORDER BY DateTimeStamp DESC
SELECT * FROM dbo.U_Dsi_RecordSetDetails WHERE FormatCode = 'ECARE2OM' ORDER BY 1, 2, SUBSTRING(SetNo,2,1), SUBSTRING(SetNo,1,1)

EXEC DBO._DSI_USP_EXPORTRIPOUT 'ECARE2OM'

dsi_sp_testswitchbox_v2 'ECARE2OM', 'ON_DEMAND'
dsi_sp_testswitchbox_v2 'ECARE2OM', 'SCHEDULED'
dsi_sp_testswitchbox_v2 'ECARE2OM', 'TEST'

************************************************************/

SET NOCOUNT ON

-----------
-- Declare variables
-----------

DECLARE @FormatCode       CHAR(10)
DECLARE @ExportCode       CHAR(10)
DECLARE @TestingFlag      CHAR(1)
DECLARE @DateTime         CHAR(14)
DECLARE @FileName         CHAR(80)

-----------
-- Set variables
-----------

SELECT

@FormatCode      = FormatCode,
@ExportCode      = ExportCode

FROM dbo.U_dsi_Parameters
WHERE SystemID = @SystemID

SET @TestingFlag   = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'Y' WHEN @ExportCode LIKE '%TST%' THEN 'Y' ELSE 'N' END;
SET @DateTime      = CONVERT(VARCHAR(8),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':','')
SET @FileName      = 'OGLETREE_CARE_employeeVerificationOGLETREEFeedProcessor_' + @DateTime + '.csv'

-----------------------
-- Build dbo.U_Dsi_DrvTbl_ECARE2OM
-----------------------

 Delete dbo.U_ECARE2OM_EEList where xeeid in (
 select  eeceeid from empcomp where eeceetype = 'TMP')

IF OBJECT_ID('dbo.U_Dsi_DrvTbl_ECARE2OM')             IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_ECARE2OM

SELECT DISTINCT

DrvUEID      = EecEmpNo,
DrvFirstName = EepNameFirst,
DrvLastName  = EepNameLast

INTO dbo.U_Dsi_DrvTbl_ECARE2OM
FROM dbo.U_ECARE2OM_EEList
JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = xEEID AND EecCoID = xCOID
JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID
JOIN dbo.JobCode WITH (NOLOCK) ON JbcJobCode = EecJobCode 
JOIN dbo.DocAckAcknowledgement WITH (NOLOCK) ON AckEEID = xEEID
JOIN dbo.DocAckDocument WITH (NOLOCK) ON docRecID = ackDocRecID
WHERE EecEmplStatus <> 'T'
--AND JbcJobFamily IN ('SHEQ','SHNON','OC','ASSOC','COUNS')
AND DocTitle LIKE '%Care.com%' 
AND ackIsCurrent = 'Y'
AND ackResponse = 'Y'

-- SELECT * FROM U_Dsi_DrvTbl_ECARE2OM ORDER BY DrvUEID

-----------------------
-- Build dbo.U_Dsi_DrvTbl_ECARE2OM_Header
-----------------------

IF OBJECT_ID('dbo.U_Dsi_DrvTbl_ECARE2OM_Header')     IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_ECARE2OM_Header

SELECT DISTINCT

DrvFileName  = @FileName,
DrvDateTime  = @DateTime

INTO dbo.U_Dsi_DrvTbl_ECARE2OM_Header
FROM dbo.U_Dsi_DrvTbl_ECARE2OM

-----------------------
-- Build dbo.U_Dsi_DrvTbl_ECARE2OM_Trailer
-----------------------

IF OBJECT_ID('dbo.U_Dsi_DrvTbl_ECARE2OM_Trailer')     IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_ECARE2OM_Trailer

SELECT DISTINCT

DrvRecCnt  = COUNT(*)

INTO dbo.U_Dsi_DrvTbl_ECARE2OM_Trailer
FROM dbo.U_Dsi_DrvTbl_ECARE2OM

-----------------------
-- Update filename
-----------------------

UPDATE dbo.U_dsi_Parameters
   SET ExportFile = @FileName
 WHERE SystemID = @SystemID
GO
CREATE View [dbo].[dsi_vwECARE2OM_Export] as
       select top 200000000 Data from dbo.U_ECARE2OM_File with (nolock)
       order by substring(RecordSet,2,2), InitialSort