/**********************************************************************************

ESUNRETP2: SunLife Retirement/Pension ExportV2

FormatCode:     ESUNRETP2
Project:        SunLife Retirement/Pension ExportV2
Client ID:      MOV1001
Date/time:      2023-04-26 16:15:47.563
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    N33
Server:         N3SUP3DB01
Database:       ULTIPRO_MVS
ExportPath:    \\us.saas\n0\data_exchange\MOV1001\Exports\
TestPath:      \\us.saas\N3\Public\MOV1001\Exports\Sunlife\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESUNRETP2_SavePath') IS NOT NULL DROP TABLE dbo.U_ESUNRETP2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESUNRETP2'


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
WHERE FormatCode = 'ESUNRETP2'
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
WHERE ExpFormatCode = 'ESUNRETP2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESUNRETP2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESUNRETP2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESUNRETP2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESUNRETP2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESUNRETP2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESUNRETP2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESUNRETP2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESUNRETP2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESUNRETP2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESUNRETP2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESUNRETP2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESUNRETP2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESUNRETP2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNRETP2];
GO
IF OBJECT_ID('U_ESUNRETP2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESUNRETP2_PDedHist];
GO
IF OBJECT_ID('U_ESUNRETP2_Header') IS NOT NULL DROP TABLE [dbo].[U_ESUNRETP2_Header];
GO
IF OBJECT_ID('U_ESUNRETP2_File') IS NOT NULL DROP TABLE [dbo].[U_ESUNRETP2_File];
GO
IF OBJECT_ID('U_ESUNRETP2_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESUNRETP2_EEList];
GO
IF OBJECT_ID('U_ESUNRETP2_drvTbl_Contribution') IS NOT NULL DROP TABLE [dbo].[U_ESUNRETP2_drvTbl_Contribution];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESUNRETP2','SunLife Retirement/Pension ExportV2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ES0ZIX000020','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ES0ZIX000020','1','H','01','1',NULL,'Record Type Code',NULL,NULL,'"drvRecordTypeCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ES0ZIX000020','3','H','01','2',NULL,'Tape ID',NULL,NULL,'"drvTapeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ES0ZIX000020','5','H','01','5',NULL,'Client ID',NULL,NULL,'"drvClientID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ES0ZIX000020','9','H','01','10',NULL,'Record Count',NULL,NULL,'"drvRecord"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ES0ZIX000020','1982','H','01','19',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ES0ZIX000020','1','D','10','1',NULL,'Record Type Code',NULL,NULL,'"D"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ES0ZIX000020','3','D','10','2',NULL,'Tape ID',NULL,NULL,'"MCS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ES0ZIX000020','5','D','10','5',NULL,'Client ID',NULL,NULL,'"C005O"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ES0ZIX000020','2','D','10','10',NULL,'Plan ID',NULL,NULL,'"05"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ES0ZIX000020','9','D','10','12',NULL,'Member Number',NULL,NULL,'"drvMemberNumberCont"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ES0ZIX000020','710','D','10','21',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ES0ZIX000020','5','D','10','731',NULL,'Product ID #1',NULL,NULL,'"99212"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ES0ZIX000020','18','D','10','736',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ES0ZIX000020','9','D','10','754',NULL,'Member Voluntary Matched Contribution Amount',NULL,NULL,'"drvMemberMatchedCont"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ES0ZIX000020','9','D','10','763',NULL,'Member Voluntary Unmatched Contribution Amount',NULL,NULL,'"drvMemberUnMatchedCont"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ES0ZIX000020','36','D','10','772',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ES0ZIX000020','9','D','10','808',NULL,'Employer Voluntary Matching Contribution Amount',NULL,NULL,'"drvVoluntaryMatchCont"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ES0ZIX000020','5','D','10','817',NULL,'Product ID #2',NULL,NULL,'"NREG9"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ES0ZIX000020','32','D','10','822',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ES0ZIX000020','9','D','10','854',NULL,'Member Voluntary Matched Contribution Amount',NULL,NULL,'"drvVoluntaryUnMatchCont"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ES0ZIX000020','1138','D','10','863',NULL,'Member Voluntary Unmatched Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('I:\Exports\Sunlife\MVSC_Cont_20230420.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Contribution OnDemand Session','202304211','EMPEXPORT','CONTODM','Apr 20 2023  8:23PM','ESUNRETP2',NULL,NULL,NULL,'202304211','Apr 21 2023 12:00AM','Apr 16 2023 12:00AM','202304211','135',NULL,NULL,'202304211',dbo.fn_GetTimedKey(),NULL,'CSMITH23',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('I:\Exports\Sunlife\MVSC_Cont_20230406.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Contribution Test Session','202304211','EMPEXPORT','CONTTEST','Apr 19 2023 12:49PM','ESUNRETP2',NULL,NULL,NULL,'202304211','Apr 21 2023 12:00AM','Apr 16 2023 12:00AM','202304211','135',NULL,NULL,'202304211',dbo.fn_GetTimedKey(),NULL,'CSMITH23',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202304199','EMPEXPORT','SCHEDULED','Apr 19 2023  7:00PM','ESUNRETP2',NULL,NULL,NULL,'202304199','Aug 22 2017  1:18PM','Aug 22 2017  1:18PM','202304121',NULL,NULL,NULL,'202304121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNRETP2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNRETP2','ExportPath','V','\\us.saas\n0\data_exchange\MOV1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNRETP2','InitialSort','C','drvInitalSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNRETP2','MultFile','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNRETP2','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNRETP2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNRETP2','TestPath','V','\\us.saas\N3\Public\MOV1001\Exports\Sunlife\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNRETP2','UDESPath','V','\\us.saas\n0\data_exchange\MOV1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNRETP2','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNRETP2','H01','dbo.U_ESUNRETP2_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNRETP2','D10','dbo.U_ESUNRETP2_drvTbl_Contribution',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESUNRETP2_drvTbl_Contribution
-----------

IF OBJECT_ID('U_ESUNRETP2_drvTbl_Contribution') IS NULL
CREATE TABLE [dbo].[U_ESUNRETP2_drvTbl_Contribution] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvMemberNumberCont] varchar(11) NULL,
    [drvMemberMatchedCont] varchar(9) NULL,
    [drvMemberUnMatchedCont] varchar(9) NULL,
    [drvVoluntaryMatchCont] varchar(9) NULL,
    [drvVoluntaryUnMatchCont] varchar(9) NULL,
    [drvInitalSort] varchar(100) NULL,
    [drvSubSort] varchar(100) NULL
);

-----------
-- Create table U_ESUNRETP2_EEList
-----------

IF OBJECT_ID('U_ESUNRETP2_EEList') IS NULL
CREATE TABLE [dbo].[U_ESUNRETP2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESUNRETP2_File
-----------

IF OBJECT_ID('U_ESUNRETP2_File') IS NULL
CREATE TABLE [dbo].[U_ESUNRETP2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ESUNRETP2_Header
-----------

IF OBJECT_ID('U_ESUNRETP2_Header') IS NULL
CREATE TABLE [dbo].[U_ESUNRETP2_Header] (
    [drvRecordTypeCode] varchar(1) NOT NULL,
    [drvTapeID] varchar(3) NOT NULL,
    [drvClientID] varchar(5) NOT NULL,
    [drvRecord] varchar(9) NULL
);

-----------
-- Create table U_ESUNRETP2_PDedHist
-----------

IF OBJECT_ID('U_ESUNRETP2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESUNRETP2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhEECurAmt] numeric NULL,
    [pdhTXRSP] numeric NULL,
    [pdhRRSPP] numeric NULL,
    [pdhRRSP] numeric NULL,
    [pdhCTFSA] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNRETP2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Move Sales Inc

Created By: Jimmy Tran
Business Analyst: Matt Sliepka
Create Date: 08/22/2017
Service Request Number: SR-2017-00165404

Purpose: SunLife Retirement/Pension ExportV2 

Revision History
----------------
Update By           Date           Request Num        Desc
Lynn Manning        12/26/2018    SR-2018-00215148    Updated so terminated employees and employees that transfer and have termed benefits are included in file
Jose Sotolongo        02/01/2019        SF 13513246        Corrected join to prevent record duplication for transfers. Due to relationship established by join not using COID, records must be limited to one company as they are summed together at the EE level.
Marie Waters        04/26/2023      TekP-2023-03-17-01    Removed demographic info from file

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESUNRETP2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESUNRETP2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESUNRETP2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESUNRETP2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESUNRETP2' ORDER BY RunID DESC;

UPDATE u_dsi_configuration SET cfgValue = dbo.dsi_fnVariable('ESUNRETP2','UdesPath') WHERE FormatCode = 'ESUNRETP2' AND CfgName = 'ExportPath'


Execute Export
--------------

EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNRETP2', 'CONTODM';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNRETP2', 'CONTTEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNRETP2', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESUNRETP2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESUNRETP2', @AllObjects = 'Y', @IsWeb = 'N'
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
    SELECT @FormatCode = 'ESUNRETP2';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CASE WHEN ExportCode = 'SCHEDULED' THEN DATEADD(DAY,-7,GETDATE()) ELSE LEFT(StartPerControl,8) END
        ,@EndDate         = CASE WHEN ExportCode = 'SCHEDULED' THEN DATEADD(SS,-1,DATEADD(d, 1, DATEDIFF(d, 0, GETDATE()))) ELSE DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8))) END
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================
    -- COMMENTED OUT ON 12/26/2018
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    --DELETE FROM dbo.U_ESUNRETP2_EEList
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    --AND xEEID IN (SELECT xEEID FROM dbo.U_ESUNRETP2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','TXRSP,RRSPP,RRSP,CTFSA');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESUNRETP2_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNRETP2_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPerControl = LEFT(PdhPerControl,8)
        -- Current Payroll Amounts
        ,PdhEECurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        -- Categorize Payroll Amounts
        ,pdhTXRSP = SUM(CASE WHEN PdhDedCode IN ('TXRSP') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdhRRSPP = SUM(CASE WHEN PdhDedCode IN ('RRSPP') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdhRRSP =  SUM(CASE WHEN PdhDedCode IN ('RRSP')  THEN PdhEECurAmt ELSE 0.00 END)        
        ,pdhCTFSA = SUM(CASE WHEN PdhDedCode IN ('CTFSA') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ESUNRETP2_PDedHist
    FROM dbo.U_ESUNRETP2_EEList WITH (NOLOCK)
    JOIN dbo.PdedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
        AND pdhCoID = xCoID
    WHERE pdhPercontrol BETWEEN @StartPerControl AND @EndPerControl
    AND pdhDedCode IN ('TXRSP','RRSPP','RRSP','CTFSA')
    GROUP BY PdhEEID, LEFT(PdhPerControl,8)
    ;

    --==========================================
    -- Build Driver Tables select * from dbo.U_dsi_BDM_EmpDeductions where eedDedcode in ('TXRSP','RRSPP','RRSP','CTFSA')
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - select * from U_ESUNRETP2_drvTbl_DemoGraphic 
    ---------------------------------
    --IF OBJECT_ID('U_ESUNRETP2_drvTbl_DemoGraphic','U') IS NOT NULL
    --    DROP TABLE dbo.U_ESUNRETP2_drvTbl_DemoGraphic;
    --SELECT DISTINCT
    --     drvEEID = xEEID
    --    ,drvCoID = xCoID
    --    ,drvRecordCount = 'D'
    --    ,drvMemberNumber = 'MC' + RTRIM(LTRIM(SUBSTRING(eecEmpno, PATINDEX('%[^0]%', eecempno +'.'), LEN(eecempno))))
    --    ,drvSSN = (SELECT EinNationalID FROM dbo.EmpIntl WITH (NOLOCK) WHERE einEEID =xEEID)
    --    ,drvNameLast = EepNameLast
    --    ,drvNameFirst = EepNameFirst
    --    ,drvAddressLine1 = EepAddressLine1
    --    ,drvAddressLine2 = EepAddressLine2
    --    ,drvAddressCity = EepAddressCity + ' ' + eepAddressState
    --    ,drvAddressState = ''
    --    ,drvAddressZipCode = EepAddressZipCode
    --    ,drvResidenceCode = CASE WHEN EepAddressState = 'NL' THEN '101'
    --                             WHEN EepAddressState = 'PE' THEN '102'
    --                             WHEN EepAddressState = 'NS' THEN '103'
    --                             WHEN EepAddressState = 'NB' THEN '104'
    --                             WHEN EepAddressState = 'QC' THEN '105'
    --                             WHEN EepAddressState = 'ON' THEN '106'
    --                             WHEN EepAddressState = 'MB' THEN '107'
    --                             WHEN EepAddressState = 'SK' THEN '108'
    --                             WHEN EepAddressState = 'AB' THEN '109'
    --                             WHEN EepAddressState = 'BC' THEN '110'
    --                             WHEN EepAddressState = 'YT' THEN '111'
    --                             WHEN EepAddressState = 'NT' THEN '112'
    --                             WHEN EepAddressState = 'NU' THEN '113'
    --                             WHEN EepAddressState NOT IN ('NL','PE','NS','NB','QC','ON','MB','SK','AB','BC','YT','NT','NU') AND EepAddressCountry = 'USA' THEN '299'
    --                             ELSE '399'
    --                             END

    --    ,drvProvinceOfEmployment = CASE WHEN eecWCState = 'NL' THEN '101'
    --                                    WHEN eecWCState = 'PE' THEN '102'
    --                                    WHEN eecWCState = 'NS' THEN '103'
    --                                    WHEN eecWCState = 'NB' THEN '104'
    --                                    WHEN eecWCState = 'QC' THEN '105'
    --                                    WHEN eecWCState = 'ON' THEN '106'
    --                                    WHEN eecWCState = 'MB' THEN '107'
    --                                    WHEN eecWCState = 'SK' THEN '108'
    --                                    WHEN eecWCState = 'AB' THEN '109'
    --                                    WHEN eecWCState = 'BC' THEN '110'
    --                                    WHEN eecWCState = 'YT' THEN '111'
    --                                    WHEN eecWCState = 'NT' THEN '112'
    --                                    WHEN eecWCState = 'NU' THEN '113'
    --                                    WHEN eecWCState NOT IN ('NL','PE','NS','NB','QC','ON','MB','SK','AB','BC','YT','NT','NU') AND EepAddressCountry = 'USA' THEN '299'
    --                                    ELSE '399'
    --                                    END
    --    ,drvDateOfBirth = EepDateOfBirth
    --    ,drvDateOfLastHire = EecDateOfLastHire
    --    ,drvDateOfCoverage = DATEADD(MONTH, 1, (EecDateOfLastHire))  --CASE WHEN eedDedCode ='TXRSP' THEN EedBenStartDate END
    --    ,drvLanguageCode = CASE WHEN eecLanguageCode ='EN' THEN 'E' END
    --    ,drvEmplStatus = Case WHEN EecEmplStatus ='A' THEN 'A'
    --                          WHEN EecEmplStatus ='L' THEN 'L'
    --                          WHEN EecEmplStatus ='T' THEN 
    --                          (CASE WHEN EecTermReason ='203' THEN 'D'
    --                                WHEN EecTermReason ='202' THEN 'R'
    --                                ELSE 'T'
    --                                END)
    --                          END

    --    ,drvEmplStatusEffDate = CASE WHEN eecEmplStatus = 'T' 
    --                                 THEN eecDateOfTermination
    --                                 ELSE eecemplstatusStartDate
    --                                 END
    --    ,drvGender = EepGender
    --    ,drvProvinceOfEmploymentEnroll =   CASE WHEN EepAddressState = 'NL' THEN '101'
    --                                            WHEN EepAddressState = 'PE' THEN '102'
    --                                            WHEN EepAddressState = 'NS' THEN '103'
    --                                            WHEN EepAddressState = 'NB' THEN '104'
    --                                            WHEN EepAddressState = 'QC' THEN '105'
    --                                            WHEN EepAddressState = 'ON' THEN '106'
    --                                            WHEN EepAddressState = 'MB' THEN '107'
    --                                            WHEN EepAddressState = 'SK' THEN '108'
    --                                            WHEN EepAddressState = 'AB' THEN '109'
    --                                            WHEN EepAddressState = 'BC' THEN '110'
    --                                            WHEN EepAddressState = 'YT' THEN '111'
    --                                            WHEN EepAddressState = 'NT' THEN '112'
    --                                            WHEN EepAddressState = 'NU' THEN '113'
    --                                            WHEN EepAddressState NOT IN ('NL','PE','NS','NB','QC','ON','MB','SK','AB','BC','YT','NT','NU') AND EepAddressCountry = 'USA' THEN '299'
    --                                            ELSE '399'
    --                                            END
    --    ,drvDateOfHire = eecDateofLastHire
    --    ,drvLangCode = CASE WHEN eecLanguageCode = 'EN' THEN 'E' END
    --    ,drvEepDateOfBirth = EepDateOfBirth
    --    ,drveecDateOfOriginalHire = EecDateOfOriginalHire
    --    ,drvEnrollmentFlag = CASE WHEN datediff(year,Getdate(),eepDateOfBirth) >= 71 THEN 'N' ELSE 'Y' END
    --    ,drvAddressEmail = EepAddressEMail
    --    ,drvPhoneFlag = CASE WHEN EepPhoneHomeNumber IS NOT NULL OR eecPhoneBusinessNumber IS NOT NULL
    --                         THEN 'Y'
    --                         ELSE 'N'
    --                         END
    --    ,drvPhoneCountryCode = CASE WHEN EepAddressCountry = 'USA' THEN 'USA' --WHEN  EepAddressCountry = 'CAN' THEN 'CAN'
    --                                ELSE ''
    --                                END
    --    ,drvPhoneCityCode = CASE WHEN eepPhoneHomeNumber IS NOT NULL THEN SUBSTRING(EepPhoneHomeNumber,1,3)
    --                             WHEN eepPhoneHomeNumber IS NULL THEN SUBSTRING(eecPhoneBusinessNumber,1,3) 
    --                             ELSE ''
    --                             END
    --    ,drvPhoneHomeNumebr = CASE WHEN eepPhoneHomeNumber IS NOT NULL THEN SUBSTRING(EepPhoneHomeNumber,4,7)
    --                               WHEN eepPhoneHomeNumber IS NULL THEN SUBSTRING(eecPhoneBusinessNumber,4,7)
    --                               ELSE ''
    --                               END
    -- --  ,drvAnnSalary = REPLACE(RIGHT('00000000000' + CONVERT(VARCHAR(11),EecAnnSalary),11),'.','')
    --    ,drvanoARNCode = anoARNCode
    --    ,drvInitalSort = eepNameLast
    --    ,drvSubSort = eepNameFirst
    --INTO dbo.U_ESUNRETP2_drvTbl_DemoGraphic
    --FROM dbo.U_ESUNRETP2_EEList WITH (NOLOCK)
    --JOIN dbo.EmpComp WITH (NOLOCK)
    --    ON EecEEID = xEEID 
    --    AND EecCoID = xCoID
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.Company WITH (NOLOCK)
    --    ON cmpCoID = xCoID
    --LEFT JOIN dbo.fnEmployeeARN() 
    --    ON EEID = xEEID 
    --    AND COID = xCOID
    --LEFT JOIN dbo.ErAcctRefNo WITH (NOLOCK) 
    --    ON anoARNID = ARNID
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = xEEID 
    --    AND EedCoID = xCoID
    --    AND EedFormatCode = @FormatCode 
    --    AND EedValidForExport = 'Y'
    --WHERE  cmpCompanyCode ='MVSC'
    --AND EEID IS NULL OR (EEID IS NOT NULL AND (anoARNCode <> '0002'))
    --AND (@ExportCode LIKE 'DEMO%' OR @ExportCode LIKE '%SCHEDULE%')

    ;
    ---------------------------------
    -- DETAIL RECORD - select * from U_ESUNRETP2_drvTbl_Contribution where drvMemberNumberCont ='MC113442'
    ---------------------------------
    IF OBJECT_ID('U_ESUNRETP2_drvTbl_Contribution','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNRETP2_drvTbl_Contribution;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvMemberNumberCont     = 'MC' + RTRIM(LTRIM(SUBSTRING(eecEmpno, PATINDEX('%[^0]%', eecempno +'.'), LEN(eecempno))))
        ,drvMemberMatchedCont    = Right('000000000' + Convert(varchar,Convert(int,(pdhRRSPP)*100)),9)
        ,drvMemberUnMatchedCont  = Right('000000000' + Convert(varchar,Convert(int,(pdhRRSP)*100)),9)
        ,drvVoluntaryMatchCont   = Right('000000000' + Convert(varchar,Convert(int,(pdhTXRSP)*100)),9)
        ,drvVoluntaryUnMatchCont = Right('000000000' + Convert(varchar,Convert(int,(pdhCTFSA)*100)),9)
        ,drvInitalSort = eepNameLast
        ,drvSubSort = eepNameFirst
    INTO dbo.U_ESUNRETP2_drvTbl_Contribution
    FROM dbo.U_ESUNRETP2_EEList WITH (NOLOCK)
    JOIN dbo.empcomp WITH (NOLOCK)
        ON eecEEID = xEEID
        AND eecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN dbo.U_ESUNRETP2_PDedHist WITH (NOLOCK) --select * from dbo.U_ESUNRETP2_PDedHist
        ON pdhEEID = xEEID
    WHERE EECCOID = EepHomeCOID        --J.S. 02/01/2019
        AND @EXPORTCODE LIKE 'CONT%'

    ;
    ---------------------------------
    -- HEADER RECORD select * from U_ESUNRETP2_Header
    ---------------------------------
    IF OBJECT_ID('U_ESUNRETP2_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNRETP2_Header;
    SELECT DISTINCT
         drvRecordTypeCode = 'H'
        ,drvTapeID = 'MCR'
        ,drvClientID = 'C005O'
        ,drvRecord = RIGHT('000000000'+ CONVERT(VARCHAR(9),( (SELECT COUNT(*) FROM dbo.U_ESUNRETP2_drvTbl_Contribution WITH (NOLOCK)))),9) --Do something with Ascdeff
    INTO dbo.U_ESUNRETP2_Header
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN @ExportCode LIKE 'DEMO%' THEN 'MVSC_Demo_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'SCHED%' THEN 'MVSC_Demo_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                 -- WHEN @ExportCode LIKE '%TEST%' THEN 'MVSC_Cont_TEST' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt' 
                                  WHEN @ExportCode LIKE 'CONT%' THEN 'MVSC_Cont_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt' 
                                 
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESUNRETP2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ESUNRETP2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESUNRETP2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304121'
       ,expStartPerControl     = '202304121'
       ,expLastEndPerControl   = '202304269'
       ,expEndPerControl       = '202304269'
WHERE expFormatCode = 'ESUNRETP2' and expExportCode = 'DEMOTEST';

   
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESUNRETP2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESUNRETP2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESUNRETP2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESUNRETP2'
   AND rpoParmType = 'expSystemID'


-- End ripout