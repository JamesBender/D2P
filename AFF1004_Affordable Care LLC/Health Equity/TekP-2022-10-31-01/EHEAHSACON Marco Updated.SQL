/**********************************************************************************

EHEAHSACON: Health Equity HSA Export

FormatCode:     EHEAHSACON
Project:        Health Equity HSA Export
Client ID:      AFF1004
Date/time:      2023-04-06 11:44:06.017
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E42
Server:         E4SUP2DB01
Database:       ULTIPRO_AFFD
Web Filename:   AFF1004_L7U81_EEHISTORY_EHEAHSACON_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHEAHSACON_SavePath') IS NOT NULL DROP TABLE dbo.U_EHEAHSACON_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHEAHSACON'


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
WHERE FormatCode = 'EHEAHSACON'
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
WHERE ExpFormatCode = 'EHEAHSACON'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHEAHSACON')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHEAHSACON'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHEAHSACON'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHEAHSACON'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHEAHSACON'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHEAHSACON'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHEAHSACON'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHEAHSACON'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHEAHSACON'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHEAHSACON'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHEAHSACON_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHEAHSACON_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHEAHSACON') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHEAHSACON];
GO
IF OBJECT_ID('U_EHEAHSACON_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHEAHSACON_PEarHist];
GO
IF OBJECT_ID('U_EHEAHSACON_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHEAHSACON_PDedHist];
GO
IF OBJECT_ID('U_EHEAHSACON_File') IS NOT NULL DROP TABLE [dbo].[U_EHEAHSACON_File];
GO
IF OBJECT_ID('U_EHEAHSACON_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHEAHSACON_EEList];
GO
IF OBJECT_ID('U_EHEAHSACON_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHEAHSACON_drvTbl];
GO
IF OBJECT_ID('U_EHEAHSACON_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHEAHSACON_DedList];
GO
IF OBJECT_ID('U_EHEAHSACON_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHEAHSACON_AuditFields];
GO
IF OBJECT_ID('U_EHEAHSACON_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHEAHSACON_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EHEAHSACON') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHEAHSACON];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHEAHSACON','Health Equity HSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EHEAHSACONZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHEAHSACONZ0','50','D','10','1',NULL,'MemberSSN',NULL,NULL,'"drvMemberSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHEAHSACONZ0','50','D','10','2',NULL,'DepositDate',NULL,NULL,'"drvDepositDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHEAHSACONZ0','50','D','10','3',NULL,'ContributionType',NULL,NULL,'"drvContributionType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHEAHSACONZ0','50','D','10','4',NULL,'Amount',NULL,NULL,'"drvAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHEAHSACONZ0','50','D','10','5',NULL,'MemberFirstName',NULL,NULL,'"drvMemberFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHEAHSACONZ0','50','D','10','6',NULL,'MemberLastName',NULL,NULL,'"drvMemberLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHEAHSACONZ0','50','D','10','7',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T|)');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHEAHSACON_20230406.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','PVVI5,XQ528,NZJDO,PXHQN,PXHS5,XQ4LG,PXJR8,YLWDC,ZHT71,L9ZOT,3S6BL,6MQO0,3RXQK,DGU1W,S3R44,L6DVS,F3PHS,1BKT3,PXHVJ,RBWRK,UMXFQ,H81FC,PTWGR,87G4G,DEMST,BG4Y9,F423P,PVSRN,ZAI2B,ZHBYO,YLUSE,LDSBV,9P8PV,1AT1U,MCFVF,8G9PC,PXGVD,MAYT6,QX1HS,U55MK,RCH50,EZWFQ,F1KX0,PXIAH,L9GKP,DGKV2,8B7GG,4WZT4,DEOV2,MB0M5,G9UQG,KLQJN,DGPRP,DKWR9,SZ6XJ,GDEDO,YY9WT,H8UIJ,6MRE6,PTWIM,MCFJG,ZAK2S,DDH7C,PVTD6,52BOS,UDU8O,S3RNJ,PXGYK,RE2NL,PXJPS,SZ64P,PXHY6,5KGOW,1TYU3,PTWLO,NF1NS,KLLQZ,PVTQC,EOG2Z,MCJ4R,PXHZG,ZZ5HE,8AU37,46GUG,PVRPA,L7O2P,EOQ56,BEEHL,PVTEG,Y8FQ0,ANATN,EQUK3,PXJM2,PXH4R,KLVVD,KKW9H,PXI0V,BJL34,AMREC,MCTQY,3YHYC,1U1RS,ELXL8,EEPVD,DKWBO,BIRPH,PR6AF,63NUM,1TLOT,F3L63,MCIAK,MB0W3,OVGK5,STHDI,DGRUA,GITM7,1HLEV,PVS9A,3SQWG,ICMD9,OZQHJ,B7AXP,PVRQN,JP3RD,H80GQ,GDF21,BE6GX,KKXC1,VW533,RBSBF,1TJV2,F07TT,9PC0V,IGI7P,NF222,45U3O,PXJG3,S3QPB,NCO6N,QTWWU,EARV7,8G5RK,YLLOW,18J47,8G8BG,AOVUU,MPPZY,S0J8E,3SBFI,L9M6S,G9SQT,3P89N,32RIX,TH7I4,3YC4S,NF0ZS,CSOS8,ZZ61R,ZMZBJ,KX3I0,G9VCB,UDTEJ,3P1S2,BF9XQ,DL04A,RDUGV,CT4WI,PDK2A,37P9Z,5CKAA,4J9WT,F44NN,EOEIL,4A2CE,RC2GT,BJMY1,DHPG2,KLXH0,TIHHD,GKK4J,F3QT7,32TLG,18KGS,Y5IPV,OZTOI,OZSY7,MPMI7,BWAQO,GKMDU,DGN5J,KLRBD,YL1MY,C24ZP,UEX7P,DK6M5,LDSZJ,KLWOJ,CSZOV,EQDGZ,GKDQH,TH91P,NCNHK,DDQ49,F42SV,6MPZK,CSG24,JMUYV,Y5J3Z,Y5J1M,5C9G6,53UXT,EONC3,BFXJV,WRLE8,GKFTI,8B4G3,1TWG4,ZP7GQ,PDNA4,3PCRM,DKVTV,CSV16,63A6E,EAJNW,VW50D,3HA3L,5CCHL,5SEGG,PTZ1K,EOB4T,JGXQM,PVT4X,PXJTU,PVRTD,PXHMN,PXI60,PUTTI,MAWW0,PVSXE,PTWEE,PXJSG,PVTH5,PUDNT,PTYPK,PTYZY,PVL6J,PTZ5C,PVT20,PVT77,PVLM9,PUDRC,PTYJ8,H8SG1,XVBIV,PXH9K,PTYO0,0HTDV,PVT64,PVSW3,PUDP0,PVT0S,PTZ6E,TH0H5,KLUOO,SZ2VN,63N8N,PTW7K,PXJIR,PVLKQ,PUDWI,PXGWR,BFB7S,6MO7Q,DF6S4,PVLD1,PVTFS,PUTUT,PVSIC,PTZ46,OZRTA,TGZVQ,3SFDS,JGTBB,1D87X,PTW37,PTTPK,PVTNR,PVTI8,PTTYP,PVL81,PXH36,PXH6A,PVRME,PTZ7M,PVRS6,PUDXM,PTW0I,PXJDG,PVLEB,PVT88,PTW9A,PUDQ2,PTYHQ,PPWV7,KKYWE,PVLHC,PVSU3,PVL9G,PTYVL,PUE0E,PTYSB,OZQYP,PDHIR,PVTRI,PXI8P,PVLB6,PVS18,PVTMJ,PXH1W,PUDZA,PXHWT,PTZ2R,PXJOP,PVLFV,PXJNA,PTVH1,PTWCU,PVSGW,PTTDD,PXJHH,L9US6,PTVPJ,PXJKW,PXI4P,PXJUV,PXHEX,PXJJW,PTVYE,PVT3F,PVLJ1,PVTP7,PTYDZ,DIL93,PVTAG,PXHNY,PTVCA,PTVEN,PVTKW,PTYR2,3SSIR,PXIBP,PXHPF,PXI7F,PVSO6,PUTW1,MAXE6,PTWB4,PTVSV,PTVRE,PXIGO,PXI26,PTYG9,NZJLI,YLYKG,PVRAX,PXIJ9,PTZHW,GIS7H,PVU1A,PVUGV,UC6CJ,PVUE0,PVLUW,RCA9A,PXHJ5,YLK17,E9UKS,PVTOT,1T4KX,3SJDH,3SN8B,PKXAY,S3S8G,OT37Q,PVU57,PUC2X,8ASSW,PXHHK,PXHTM,PXHKH,PVTNC,PTZN9,PUE4K,INZ3E,JN7T9,PUU46,PVRKX,PXGMT,S08QR,DKXCA,I5VOL,AFB01,PTZPO,XVRN8,PXF9W,PVVMI,PTZFD,63JBK,PVT8S,PUCTW,PUDH4,DI203,PVSJU,PUU28,PSBEJ,PUCGR,PVRH1,PVRJS,PUCB3,S4OCI,PUCXU,SZ4NF,PQKVG,PQSKM,PQDO6,PVUFG,PUDAW,UDXFX,AMRBI,PVLTJ,H8T7H,H8TLF,PVTRP,OAUNY,PXG5G,TH6EI,Y5IL4,PUD02,DB1IF,53X90,PXH7S,YWGNW,JP2AI,06SYM,PVTIW,PUDL1,PVU9O,PUCYX,PVTEB,PVTFN,PUU5C,3KN13,PVU6K,PUTXR,PUD2J,PVTVR,SU3IE,QX3JB,PVT4H,KLMNH,PUCWB,PUD9E,PVT7E,PXFRK,XILJO,PVTK8,TH4RI,OAVK4,SZ7WF,JGZOL,PVVJV,LMY1K,LMQKW,KL0E4,PUU6M,PXFL8,XIGRK,DB0TZ,PTZJ9,PUDII,50NGI,3OVGU,DAZRL,PVTZJ,DGJXO,PTZGL,XQ5OE,PKWMH,PVUBC,5S880,3S1EH,5CGCO,PUCLR,S0U9U,PTZE5,PXG0F,PVLQ0,87KRU,TGYM9,PUDFK,E9XY3,G7ZXQ,PXFHO,6MP7K,PTZOH,PTZL2,BEG7W,TH8O3,PVT5U,PUE3H,PUDE2,PXI3I,PUDMB,CSHJ2,QX3VD,PXHG5,I9LH6,E8LOJ,EOYXK,PXF7X,S3PPA,DCI7T,JOXYV,JGUKE,EFHZ6,2SNE0,PUDCD,PVLWZ,PXFBB,PXG3G,18JQT,PVVH0,DJZ8H,MCR7J,PVVL1,PVTQ4,PVUCK,PUCEE,KLOUI,LMRQI,KILLJ,PUDJO,NXXW1,PVRDR,2SZS6,UDVX6,32V0F,S46ZG,YYCZN,DAGQK,YM0S4,S3THI,BPZGD,PVRFP,PVU2U,32PZG,37D2Q,L4IBV,PVLRH,PVU81,EA9BE,BEWK8,E9PND,QTOBX,Y5HWD,LNCZ5,S4NHP,TH5I0,SZ3EE,PUE1L,PUD4B,BF9JS,PXGJN,KG4T9,XVS93,PXH0I,S0HVU,U9FUD,ZHR9N,PVTLR,QX3T3,Y5JDF,Y5IU2,Y5JAE,AN3TD,DAD5E,WX59Q,PVSA7,PVU40,MCF6P,LOEQ9,PUU84,PVRC8,PUCJQ,PUE5Q,JP0S4,BG0D6,CTGCP,MX972,080YU,GIV6B',NULL,NULL,NULL,'Health Equity HSA Export-ONDMD','202304071','EMPEXPORT','ONDEM_XOE','Jan 21 2023 12:00AM','EHEAHSACON',NULL,NULL,NULL,'202304071','Dec 26 2022 12:00AM','Dec 30 1899 12:00AM','202304071',NULL,'eecPayGroup','ADDL','202304071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Equity HSA Export-Sched','202212269','EMPEXPORT','SCH_EHEAHS','Jan 21 2023 12:00AM','EHEAHSACON',NULL,NULL,NULL,'202212269','Dec 26 2022 12:00AM','Dec 30 1899 12:00AM','202212261',NULL,'eecPayGroup','ACARE,CEN2,CEN,CPW,DDS,LAB,ADDL,GPO,LAB2,TDG','202212261',dbo.fn_GetTimedKey(),NULL,'us3mLaAFF1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','PVVI5,XQ528,NZJDO,PXHQN,PXHS5,XQ4LG,PXJR8,YLWDC,ZHT71,L9ZOT,3S6BL,6MQO0,3RXQK,DGU1W,S3R44,L6DVS,F3PHS,1BKT3,PXHVJ,RBWRK,UMXFQ,H81FC,PTWGR,87G4G,DEMST,BG4Y9,F423P,PVSRN,ZAI2B,ZHBYO,YLUSE,LDSBV,9P8PV,1AT1U,MCFVF,8G9PC,PXGVD,MAYT6,QX1HS,U55MK,RCH50,EZWFQ,F1KX0,PXIAH,L9GKP,DGKV2,8B7GG,4WZT4,DEOV2,MB0M5,G9UQG,KLQJN,DGPRP,DKWR9,SZ6XJ,GDEDO,YY9WT,H8UIJ,6MRE6,PTWIM,MCFJG,ZAK2S,DDH7C,PVTD6,52BOS,UDU8O,S3RNJ,PXGYK,RE2NL,PXJPS,SZ64P,PXHY6,5KGOW,1TYU3,PTWLO,NF1NS,KLLQZ,PVTQC,EOG2Z,MCJ4R,PXHZG,ZZ5HE,8AU37,46GUG,PVRPA,L7O2P,EOQ56,BEEHL,PVTEG,Y8FQ0,ANATN,EQUK3,PXJM2,PXH4R,KLVVD,KKW9H,PXI0V,BJL34,AMREC,MCTQY,3YHYC,1U1RS,ELXL8,EEPVD,DKWBO,BIRPH,PR6AF,63NUM,1TLOT,F3L63,MCIAK,MB0W3,OVGK5,STHDI,DGRUA,GITM7,1HLEV,PVS9A,3SQWG,ICMD9,OZQHJ,B7AXP,PVRQN,JP3RD,H80GQ,GDF21,BE6GX,KKXC1,VW533,RBSBF,1TJV2,F07TT,9PC0V,IGI7P,NF222,45U3O,PXJG3,S3QPB,NCO6N,QTWWU,EARV7,8G5RK,YLLOW,18J47,8G8BG,AOVUU,MPPZY,S0J8E,3SBFI,L9M6S,G9SQT,3P89N,32RIX,TH7I4,3YC4S,NF0ZS,CSOS8,ZZ61R,ZMZBJ,KX3I0,G9VCB,UDTEJ,3P1S2,BF9XQ,DL04A,RDUGV,CT4WI,PDK2A,37P9Z,5CKAA,4J9WT,F44NN,EOEIL,4A2CE,RC2GT,BJMY1,DHPG2,KLXH0,TIHHD,GKK4J,F3QT7,32TLG,18KGS,Y5IPV,OZTOI,OZSY7,MPMI7,BWAQO,GKMDU,DGN5J,KLRBD,YL1MY,C24ZP,UEX7P,DK6M5,LDSZJ,KLWOJ,CSZOV,EQDGZ,GKDQH,TH91P,NCNHK,DDQ49,F42SV,6MPZK,CSG24,JMUYV,Y5J3Z,Y5J1M,5C9G6,53UXT,EONC3,BFXJV,WRLE8,GKFTI,8B4G3,1TWG4,ZP7GQ,PDNA4,3PCRM,DKVTV,CSV16,63A6E,EAJNW,VW50D,3HA3L,5CCHL,5SEGG,PTZ1K,EOB4T,JGXQM,PVT4X,PXJTU,PVRTD,PXHMN,PXI60,PUTTI,MAWW0,PVSXE,PTWEE,PXJSG,PVTH5,PUDNT,PTYPK,PTYZY,PVL6J,PTZ5C,PVT20,PVT77,PVLM9,PUDRC,PTYJ8,H8SG1,XVBIV,PXH9K,PTYO0,0HTDV,PVT64,PVSW3,PUDP0,PVT0S,PTZ6E,TH0H5,KLUOO,SZ2VN,63N8N,PTW7K,PXJIR,PVLKQ,PUDWI,PXGWR,BFB7S,6MO7Q,DF6S4,PVLD1,PVTFS,PUTUT,PVSIC,PTZ46,OZRTA,TGZVQ,3SFDS,JGTBB,1D87X,PTW37,PTTPK,PVTNR,PVTI8,PTTYP,PVL81,PXH36,PXH6A,PVRME,PTZ7M,PVRS6,PUDXM,PTW0I,PXJDG,PVLEB,PVT88,PTW9A,PUDQ2,PTYHQ,PPWV7,KKYWE,PVLHC,PVSU3,PVL9G,PTYVL,PUE0E,PTYSB,OZQYP,PDHIR,PVTRI,PXI8P,PVLB6,PVS18,PVTMJ,PXH1W,PUDZA,PXHWT,PTZ2R,PXJOP,PVLFV,PXJNA,PTVH1,PTWCU,PVSGW,PTTDD,PXJHH,L9US6,PTVPJ,PXJKW,PXI4P,PXJUV,PXHEX,PXJJW,PTVYE,PVT3F,PVLJ1,PVTP7,PTYDZ,DIL93,PVTAG,PXHNY,PTVCA,PTVEN,PVTKW,PTYR2,3SSIR,PXIBP,PXHPF,PXI7F,PVSO6,PUTW1,MAXE6,PTWB4,PTVSV,PTVRE,PXIGO,PXI26,PTYG9,NZJLI,YLYKG,PVRAX,PXIJ9,PTZHW,GIS7H,PVU1A,PVUGV,UC6CJ,PVUE0,PVLUW,RCA9A,PXHJ5,YLK17,E9UKS,PVTOT,1T4KX,3SJDH,3SN8B,PKXAY,S3S8G,OT37Q,PVU57,PUC2X,8ASSW,PXHHK,PXHTM,PXHKH,PVTNC,PTZN9,PUE4K,INZ3E,JN7T9,PUU46,PVRKX,PXGMT,S08QR,DKXCA,I5VOL,AFB01,PTZPO,XVRN8,PXF9W,PVVMI,PTZFD,63JBK,PVT8S,PUCTW,PUDH4,DI203,PVSJU,PUU28,PSBEJ,PUCGR,PVRH1,PVRJS,PUCB3,S4OCI,PUCXU,SZ4NF,PQKVG,PQSKM,PQDO6,PVUFG,PUDAW,UDXFX,AMRBI,PVLTJ,H8T7H,H8TLF,PVTRP,OAUNY,PXG5G,TH6EI,Y5IL4,PUD02,DB1IF,53X90,PXH7S,YWGNW,JP2AI,06SYM,PVTIW,PUDL1,PVU9O,PUCYX,PVTEB,PVTFN,PUU5C,3KN13,PVU6K,PUTXR,PUD2J,PVTVR,SU3IE,QX3JB,PVT4H,KLMNH,PUCWB,PUD9E,PVT7E,PXFRK,XILJO,PVTK8,TH4RI,OAVK4,SZ7WF,JGZOL,PVVJV,LMY1K,LMQKW,KL0E4,PUU6M,PXFL8,XIGRK,DB0TZ,PTZJ9,PUDII,50NGI,3OVGU,DAZRL,PVTZJ,DGJXO,PTZGL,XQ5OE,PKWMH,PVUBC,5S880,3S1EH,5CGCO,PUCLR,S0U9U,PTZE5,PXG0F,PVLQ0,87KRU,TGYM9,PUDFK,E9XY3,G7ZXQ,PXFHO,6MP7K,PTZOH,PTZL2,BEG7W,TH8O3,PVT5U,PUE3H,PUDE2,PXI3I,PUDMB,CSHJ2,QX3VD,PXHG5,I9LH6,E8LOJ,EOYXK,PXF7X,S3PPA,DCI7T,JOXYV,JGUKE,EFHZ6,2SNE0,PUDCD,PVLWZ,PXFBB,PXG3G,18JQT,PVVH0,DJZ8H,MCR7J,PVVL1,PVTQ4,PVUCK,PUCEE,KLOUI,LMRQI,KILLJ,PUDJO,NXXW1,PVRDR,2SZS6,UDVX6,32V0F,S46ZG,YYCZN,DAGQK,YM0S4,S3THI,BPZGD,PVRFP,PVU2U,32PZG,37D2Q,L4IBV,PVLRH,PVU81,EA9BE,BEWK8,E9PND,QTOBX,Y5HWD,LNCZ5,S4NHP,TH5I0,SZ3EE,PUE1L,PUD4B,BF9JS,PXGJN,KG4T9,XVS93,PXH0I,S0HVU,U9FUD,ZHR9N,PVTLR,QX3T3,Y5JDF,Y5IU2,Y5JAE,AN3TD,DAD5E,WX59Q,PVSA7,PVU40,MCF6P,LOEQ9,PUU84,PVRC8,PUCJQ,PUE5Q,JP0S4,BG0D6,CTGCP,MX972,080YU,GIV6B',NULL,NULL,NULL,'Health Equity HSA Export-Test','202304071','EMPEXPORT','TEST_XOE','Apr  6 2023 10:56AM','EHEAHSACON',NULL,NULL,NULL,'202304071','Apr  7 2023 12:00AM','Apr  2 2023 12:00AM','202304071','86','eecPayGroup','ADDL','202304071',dbo.fn_GetTimedKey(),NULL,'us3kEpAFF1004',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEAHSACON','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEAHSACON','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEAHSACON','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEAHSACON','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEAHSACON','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEAHSACON','SubSort2','C','drvsubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEAHSACON','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEAHSACON','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEAHSACON','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHEAHSACON','D10','dbo.U_EHEAHSACON_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EHEAHSACON
-----------

IF OBJECT_ID('U_dsi_BDM_EHEAHSACON') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHEAHSACON] (
    [BdmRecType] varchar(3) NOT NULL,
    [BdmCOID] char(5) NULL,
    [BdmEEID] char(12) NOT NULL,
    [BdmDepRecID] char(12) NULL,
    [BdmSystemID] char(12) NULL,
    [BdmRunID] varchar(32) NULL,
    [BdmDedRowStatus] varchar(256) NULL,
    [BdmRelationship] char(3) NULL,
    [BdmDateOfBirth] datetime NULL,
    [BdmDedCode] char(5) NULL,
    [BdmDedType] varchar(32) NULL,
    [BdmBenOption] char(6) NULL,
    [BdmBenStatus] char(1) NULL,
    [BdmBenStartDate] datetime NULL,
    [BdmBenStopDate] datetime NULL,
    [BdmBenStatusDate] datetime NULL,
    [BdmBenOptionDate] datetime NULL,
    [BdmChangeReason] char(6) NULL,
    [BdmStartDate] datetime NULL,
    [BdmStopDate] datetime NULL,
    [BdmIsCobraCovered] char(1) NULL,
    [BdmCobraReason] char(6) NULL,
    [BdmDateOfCOBRAEvent] datetime NULL,
    [BdmIsPQB] char(1) NULL,
    [BdmIsChildOldest] char(1) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [BdmUSGField2] varchar(256) NULL,
    [BdmUSGDate1] datetime NULL,
    [BdmUSGDate2] datetime NULL,
    [BdmTVStartDate] datetime NULL,
    [BdmSessionID] varchar(32) NULL,
    [BdmEEAmt] money NULL,
    [BdmEECalcRateOrPct] decimal NULL,
    [BdmEEGoalAmt] money NULL,
    [BdmEEMemberOrCaseNo] char(40) NULL,
    [BdmERAmt] money NULL,
    [BdmNumSpouses] int NULL,
    [BdmNumChildren] int NULL,
    [BdmNumDomPartners] int NULL,
    [BdmNumDPChildren] int NULL
);

-----------
-- Create table U_EHEAHSACON_Audit
-----------

IF OBJECT_ID('U_EHEAHSACON_Audit') IS NULL
CREATE TABLE [dbo].[U_EHEAHSACON_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EHEAHSACON_AuditFields
-----------

IF OBJECT_ID('U_EHEAHSACON_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHEAHSACON_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EHEAHSACON_DedList
-----------

IF OBJECT_ID('U_EHEAHSACON_DedList') IS NULL
CREATE TABLE [dbo].[U_EHEAHSACON_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EHEAHSACON_drvTbl
-----------

IF OBJECT_ID('U_EHEAHSACON_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHEAHSACON_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvsubsort2] varchar(1) NOT NULL,
    [drvMemberSSN] char(11) NULL,
    [drvDepositDate] datetime NULL,
    [drvContributionType] varchar(2) NULL,
    [drvAmount] varchar(30) NULL,
    [drvMemberFirstName] varchar(100) NULL,
    [drvMemberLastName] varchar(100) NULL,
    [drvEmployeeID] char(9) NULL
);

-----------
-- Create table U_EHEAHSACON_EEList
-----------

IF OBJECT_ID('U_EHEAHSACON_EEList') IS NULL
CREATE TABLE [dbo].[U_EHEAHSACON_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHEAHSACON_File
-----------

IF OBJECT_ID('U_EHEAHSACON_File') IS NULL
CREATE TABLE [dbo].[U_EHEAHSACON_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EHEAHSACON_PDedHist
-----------

IF OBJECT_ID('U_EHEAHSACON_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHEAHSACON_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPayGroup] char(6) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhSource1] numeric NULL
);

-----------
-- Create table U_EHEAHSACON_PEarHist
-----------

IF OBJECT_ID('U_EHEAHSACON_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHEAHSACON_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [prgpaygroup] char(6) NOT NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHEAHSACON]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Affordable Care LLC

Created By: Marco Lagrosa
Business Analyst: Kim Ephraim
Create Date: 12/26/2022
Service Request Number: TekP-2022-10-31-01

Purpose: Health Equity HSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        02/22/2023       TekP-2022-10-31-03    Added Pearhist and switched to using it for paydate
Marie Waters        03/27/2023       TekP-2022-10-31-03    Initial developer added the Dedcodes for the BDM but not the dbo.U_dsi_BDM_Configuration inserts. Added inserts and table to the query. 
Marie Watters		04/06/2023	   TekP-2022-10-31-03	added ONDEM session 
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHEAHSACON';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHEAHSACON';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHEAHSACON';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHEAHSACON';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHEAHSACON' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEAHSACON', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEAHSACON', 'TEST_XOE';


EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEAHSACON', 'SCH_EHEAHS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHEAHSACON';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHEAHSACON', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHEAHSACON';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;
        
    --Audit Table
    IF OBJECT_ID('U_EHEAHSACON_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHEAHSACON_AuditFields;
    CREATE TABLE dbo.U_EHEAHSACON_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EHEAHSACON_AuditFields VALUES ('EmpDed','EedEEGoalAmt'); 
    INSERT INTO dbo.U_EHEAHSACON_AuditFields VALUES ('empcomp','eecemplstatus');  -- MW Added but Audit is not being used
    
    
    -- Create audit table
    IF OBJECT_ID('U_EHEAHSACON_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHEAHSACON_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EHEAHSACON_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EHEAHSACON_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EHEAHSACON_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EHEAHSACON_Audit ON dbo.U_EHEAHSACON_Audit (audKey1Value, audKey2Value)

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EHEAHSACON_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHEAHSACON_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSA,HSAC,HSAF,HSAFC';
    IF OBJECT_ID('U_EHEAHSACON_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHEAHSACON_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHEAHSACON_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


        --MW Added 3/27/2023
    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EHEAHSACON_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHEAHSACON_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhPayGroup
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  and PdhDedCode IN ('HSA','HSAC','HSAF','HSAFC')THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl and  PdhDedCode IN ('HSA','HSAC','HSAF','HSAFC')THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
       -- ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        --,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('HSA','HSAC','HSAF','HSAFC') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EHEAHSACON_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EHEAHSACON_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID,PdhPayGroup
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EHEAHSACON_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHEAHSACON_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,prgpaygroup
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
       -- ,PehCurAmtYTD           = SUM(PehCurAmt)
       -- ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
       -- ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
       -- ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EHEAHSACON_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PehEEID, prgpaygroup
    HAVING SUM(PehCurAmt) <> 0.00;
        

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHEAHSACON_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHEAHSACON_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHEAHSACON_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        ,drvsubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvMemberSSN = eepSSN
        ,drvDepositDate = CAST(PrgPayDate as DATETIME)
        ,drvContributionType = CASE WHEN PdhEECurAmt is not null   THEN 'EE' END
        ,drvAmount = CAST( CONVERT(DECIMAL(10,2),PdhEECurAmt) as varchar)
        ,drvMemberFirstName = EepNameFirst
        ,drvMemberLastName = EepNameLast
        ,drvEmployeeID = EecEmpNo
    INTO dbo.U_EHEAHSACON_drvTbl
    FROM dbo.U_EHEAHSACON_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         --and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' and eecdateoftermination >@Enddate
   --                                     and EXISTS(select 1 from dbo.U_EHEAHSACON_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T'))) --- being called but was not included in the audittable inserts
    
    LEFT JOIN dbo.U_dsi_BDM_EHEAHSACON WITH (NOLOCK) -- MW added 3/27/2023
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EHEAHSACON_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID 
    JOIN dbo.U_EHEAHSACON_PEarHist WITH (NOLOCK) -- MW added 2/22/2023
        ON peheeid =  xEEID
        and prgpaygroup =  Eecpaygroup
   --JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
   --                FROM dbo.PgPayPer WITH (NOLOCK)
   --                WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
   --                GROUP BY PgpPayGroup) as PGrp
   -- on PGrp.PgpPayGroup = eecpaygroup
   Where  (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and (eectermreason <>'TRO'  or  (PdhEECurAmt > 0 or PdhSource1 > 0) ) )) -- MW added
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEHEAHSACON_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHEAHSACON_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EHEAHSACON%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304071'
       ,expStartPerControl     = '202304071'
       ,expLastEndPerControl   = '202304071'
       ,expEndPerControl       = '202304071'
WHERE expFormatCode = 'EHEAHSACON'and expexportcode = 'TEST_XOE' ;

UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304071'
       ,expStartPerControl     = '202304071'
       ,expLastEndPerControl   = '202304071'
       ,expEndPerControl       = '202304071'
WHERE expFormatCode = 'EHEAHSACON'and expexportcode = 'ONDEM_XOE' ;

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHEAHSACON_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHEAHSACON_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHEAHSACON' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHEAHSACON'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHEAHSACON'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHEAHSACON', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHEAHSACON', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHEAHSACON', 'UseFileName', 'V', 'Y'


-- End ripout