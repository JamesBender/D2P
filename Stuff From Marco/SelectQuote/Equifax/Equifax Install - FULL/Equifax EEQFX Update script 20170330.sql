/*****  
  Lynn Manning
  Last Updated:  03/30/2017	
  Update the EEQFX stored procedures

******/


If OBJECT_ID('dsi_sp_BuildDriverTables_EEQFX') IS NOT NULL DROP PROCEDURE dbo.dsi_sp_BuildDriverTables_EEQFX;
GO
If OBJECT_ID('U_Dsi_EquifaxCustom_Backup') IS NULL 
	CREATE TABLE dbo.U_Dsi_EquifaxCustom_Backup (
		 SP_NAME VARCHAR(50)
		,SP_CODE NVARCHAR(MAX)
		,DateCreated DATETIME );
If OBJECT_ID('dsi_sp_BuildDriverTables_EEQFX_Custom') IS NOT NULL 
	BEGIN	
		INSERT INTO dbo.U_Dsi_EquifaxCustom_Backup
		SELECT DISTINCT A.NAME AS SP_NAME, M.DEFINITION AS SP_Code, GETDATE()
		FROM SYS.SQL_MODULES M 
		INNER JOIN SYS.OBJECTS A ON M.OBJECT_ID = A.OBJECT_ID
		WHERE A.Name = 'dsi_sp_BuildDriverTables_EEQFX_Custom' AND  A.type = 'P';
	END
GO
If OBJECT_ID('U_EEQFX_290_drvtbl') IS NOT NULL DROP TABLE dbo.U_EEQFX_290_drvtbl;
GO
If OBJECT_ID('U_EEQFX_140_drvtbl') IS NOT NULL DROP TABLE dbo.U_EEQFX_140_drvtbl;
GO
DELETE FROM dbo.AscDefF WHERE AdfHeaderSystemID = 'EEQFX00000Z0' AND AdfSetNumber = '97';
GO
INSERT INTO dbo.AscDefF(AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000HEADER"','1','(''DA''=''F'')','EEQFX00000Z0','15','H','97','1',NULL,'I9 Header record Type',NULL,NULL);
INSERT INTO dbo.AscDefF(AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"spaces"','2','(''SS''=''F'')','EEQFX00000Z0','91','H','97','16',NULL,'I9 Header filler',NULL,NULL);
INSERT INTO dbo.AscDefF(AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVersion"','3','(''UA''=''F'')','EEQFX00000Z0','5','H','97','107',NULL,'I9 Header version',NULL,NULL);
INSERT INTO dbo.AscDefF(AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceID"','4','(''UA''=''F'')','EEQFX00000Z0','5','H','97','112',NULL,'I9 Header source id',NULL,NULL);
INSERT INTO dbo.AscDefF(AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceType"','5','(''UA''=''F'')','EEQFX00000Z0','20','H','97','117',NULL,'I9 Header Source type',NULL,NULL);
INSERT INTO dbo.AscDefF(AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmissionType"','6','(''UA''=''F'')','EEQFX00000Z0','1','H','97','137',NULL,'I9 Header Submission type',NULL,NULL);
INSERT INTO dbo.AscDefF(AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceService"','7','(''UA''=''F'')','EEQFX00000Z0','5','H','97','138',NULL,'I9 Header Source Service',NULL,NULL);
INSERT INTO dbo.AscDefF(AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplidOnly"','8','(''UA''=''F'')','EEQFX00000Z0','1','H','97','143',NULL,'I9 Header Emplid only',NULL,NULL);
GO
UPDATE dbo.AscDefH SET AdhFormatName = 'EQUIFAX Export v02.00 Format v5' WHERE AdhFormatCode = 'EEQFX';
GO
IF OBJECT_ID('U_EEQFX_372_drvtbl') IS NULL
CREATE TABLE [dbo].[U_EEQFX_372_drvtbl] (
    [drvsubsort] varchar(32) NULL,
    [drveeid] varchar(12) NULL,
    [drvCoCode] varchar(12) NULL,
    [drvssn] varchar(15) NULL,
    [drvuserid] varchar(32) NULL,
    [drvuserrole] varchar(24) NULL,
    [drvI9location] varchar(32) NULL,
    [drvhrxrole] varchar(50) NULL
);
IF OBJECT_ID('U_EEQFX_372prior_drvtbl') IS NULL
CREATE TABLE [dbo].[U_EEQFX_372prior_drvtbl] (
    [drvsubsort] varchar(32) NULL,
    [drveeid] varchar(12) NULL,
    [drvCoCode] varchar(12) NULL,
    [drvssn] varchar(15) NULL,
    [drvuserid] varchar(32) NULL,
    [drvuserrole] varchar(24) NULL,
    [drvI9location] varchar(32) NULL,
    [drvhrxrole] varchar(50) NULL
);


GO
IF EXISTS (SELECT 1 FROM dbo.U_Dsi_Configuration WHERE FormatCode = 'EEQFX' AND cfgName = 'vCustom')
BEGIN
	DECLARE @CfgValue VARCHAR(1);
	SET @CfgValue = (SELECT cfgValue FROM dbo.U_Dsi_Configuration WHERE FormatCode = 'EEQFX' AND cfgName = 'vCustom')
	INSERT INTO dbo.U_dsi_Configuration(FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEQFX','cCustom','C', @CfgValue);
	Delete dbo.U_dsi_Configuration from dbo.U_dsi_Configuration WHERE Formatcode = 'EEQFX' AND cfgName = 'vCustom' ; 
END
GO

---------------------------------
-- insert main stored proc
---------------------------------

/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EEQFX]    Script Date: 03/28/2016 11:26:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEQFX]
@systemid CHAR(12)
AS

/************************************************************

Created By: Diane Hendrix
Create Date: March 2013
FormatCode:  EEQFX
EEQFX: Rewrite TALX to split by companies AND to get solid codebase since we can't tell version of prior ETALX

Equifax Export

Revision History
-----------------
Name			Date		Spec Ver	Description   
Lynn Manning	09/09/2015				Resort the order of the 4 DELETE statements to clean up EELIST to resolve issue with multiple terms records,
										Add semi colons to end of statements
Lynn Manning	10/13/2015				UPDATE scheduled job script at end of comments
Lynn Manning	10/23/2015				UPDATE so vTCIID AND vUCXAcctNo can be translated values FROM the translations table
Lynn Manning	12/08/2015	v2.6		SOW 2.6 UPDATE 220 record - UPDATE to exclude Local tax WHERE PthIsEmployer = 'Y'
Lynn Manning	02/23/2016				UPDATE SELECT statement for table U_EEQFX_History (210 record) to use a LEFT JOIN vs a JOIN for PEarHist (case 06379522 Amsted)
Lynn Manning	03/25/2016	v2.7		UPDATE the SUM in 210 record to use earncodes "NOT IN ('R','O','B','C')" instead of "charindex"; set drvYTDWages to 0 in 290 record,
										update SELECTion criteria for 290 to include ONLY when YTD FUTA Wages > 0 in current calendar year regardless of employment status,
										Set Location Name in 140 record to the Legal Entity Name for FEIN (NOT the location name per Equifax).
Lynn Manning	01/06/2017				For 220 record, exclude PayReg record when prgCheckAddMode = 'N' (manual adj-accrual import) and prgTotEarnAmt = 0
Lynn Manning	02/10/2017				210 record: Update drvYear1Date = SUBSTRING(CONVERT(VARCHAR(10), @EndDate, 112), 1, 4) + '0101' instead of SUBSTRING(CONVERT(VARCHAR(10), getdate(), 112), 1, 4) + '0101' WHERE drvYear1Date IS NULL;
Lynn Manning	03/30/2017				Update I9 fields in EEQFX_Custom sp, TRIM fields from translations_v2 to account for any spaces in codes, create table U_Dsi_EquifaxCustom_Backup to save the Custom SP if one exists already.



-- This module is not to be modified, unless the modification is needed for ALL EQFX clients


Purpose: To provide a delivered EQFX export module that does not get
 UPDATEd for client specific requirements.  There is a separate module
 called by this one multiple times, that is to be used for any client modifications

** Please note some clients have different Equifax company codes (drvcocode). 
 In such case data needs to be summed within the Equifax company. Also, client
may have different files created based on Equifax company. 
 There may also be override configuration,variable or translations in u_dsi_translation_v2 to use

If recordsets are in the translations, they are to not be processed, so query should not create 
records in the table.

-- This module is not to be modified, unless the modification is needed for ALL EQFX clients

Employees Included in File -
 All employees paid in the year of the Range End Date, as well as all non-terminated
 employees.  Also will included terminated employees terminated with the last 365 days.
 Please note the 365 days is stored in the U_Configuration Table AND can be
 modified based on client requirements.

202/200 - Employee General Information - Everyone gets either a 202/200 record all of the time AND 
 it is one record per EE (not based on company so it would never have multiple records).   

210 - Employee Pay Information - Anyone paid in the last 3 years gets a 210 record.  
 There is one record per EE with YTD pay information.  

220 - Employee Pay Detail Information - Anyone paid in the current pay period. 
 This record could have multiple records per PrgPayDate/PrgPeriodEndDate.  
 Records with the same PrgPayDate/PrgPeriodEndDate are summed together. This
 record is used by Work Number AND UCX

The record types below are only created for clients using the various products.

290 - One record by company per location (based on pay history), for all employees paid
 FROM a US or US territory location. These records will be created if client has WOTC.

140 - On record for each distinct company/location combination included in the 290 records

350 - One record for each employee based on current location.  These records will
 be created for clients using the I-9

160 - One record for each location included in the 350 records

230 - One record for each employee, having a 200/202 record.  The code is not
 in the delivered module, but needs to be added to the custom module
 if the client uses the benefits product.  If there is no way to determin
 employees eligible for med/den/vis coverage, THEN only include those having coverage

240 - One record for each dependent in which the employee has a 230 record AND is
 currently enrolled in a medical plan.

The following sp - dsi_sp_BuildDriverTables_EEQFX_Custom , may be customized per client
  AND is executed FROM this code as indicated using the parameter indicated

parameter  WHEN executed
EELIST  after the EELIST record is created
EMPWORK  After the EMPWORK table is created
202   after the 202/200 record is created
210   after the 210 record is created
220   after the 220 record is created
BENEFITS  if the benefits product is used
290   after the 290 record is created if the WOTC product is used
140   after the 140 record is created if the WOTC product is used
I9   after the 350 record is created if the I-9 product is used
FINAL   at the end of the program, for any customizations not done above

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEQFX', 'Y'

SELECT * FROM U_dsi_Configuration WHERE FormatCode = 'EEQFX'
SELECT * FROM U_dsi_sqlclauses WHERE FormatCode = 'EEQFX'
SELECT * FROM U_dsi_parameters WHERE FormatCode = 'EEQFX'
SELECT * FROM U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEQFX' ORDER BY DateTimeStamp DESC;

DELETE FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEQFX' AND Locked = 1

-- Added a Session 'TEST' so that clients create test files as they want to 
 this allows them to send test files after they are live

EXEC dsi_sp_testswitchbox_v2 'EEQFX', 'TEST'
EXEC dsi_sp_testswitchbox_v2 'EEQFX', 'ONDEMAND'
EXEC dsi_sp_testswitchbox_v2 'EEQFX', 'SCHEDULED'


--========================================================================================

Below is the text to schedule job.  Job is to be scheduled WEEKLY on FRIDAY at 3:13 am
It will SELECT period control seq >= 2 FROM prior Fri thru seq 1 current Friday:

UPDATE AscExp
  set expLastStartPerControl = CONVERT(VARCHAR(10),getdate()-7,112)+ '2',
      expLastEndPerControl = CONVERT(VARCHAR(10),getdate(),112) + '1',
      expExported = CONVERT(VARCHAR(8),GetDate(),112)
  where expFormatCode = 'EEQFX' AND expExportCode = 'SCHEDULED';
GO
EXEC dbo.dsi_sp_testswitchbox_v2 'EEQFX', 'SCHEDULED';
GO

--=======================================================================================


-- This module is not to be modified, unless the modification is needed for ALL EQFX clients

************************************************************/

BEGIN


	/***************************
	COLLECT DATE PARAMETERS
	****************************/
	DECLARE	@StartDate DATETIME,
			@EndDate DATETIME,
			@StartPerControl CHAR(9),
			@EndPerControl CHAR(9),
			@FormatCode CHAR(10),
			@ExportCode CHAR(10),
			@ExportFile CHAR(200);

	SELECT 
			@StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
			@EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
			@StartPerControl = startpercontrol,
			@EndPerControl  = endpercontrol,
			@FormatCode = formatcode,
			@ExportCode = Exportcode,
			@Exportfile = ExportFile
	FROM dbo.U_dsi_Parameters 
	WHERE formatcode = 'EEQFX';

	--PRINT CONVERT(VARCHAR(8),@EndDate,112)

	/**********************************
	DROP TABLE IF IT ALREADY EXISTS
	***********************************/
	IF OBJECT_ID ('U_EEQFX_Coid_Equifaxco') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_Coid_Equifaxco ;
	IF OBJECT_ID ('U_EEQFX_EEList_EquifaxCo') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_EEList_EquifaxCo;
	IF OBJECT_ID ('U_EEQFX_140_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_140_drvtbl;
	IF OBJECT_ID ('U_EEQFX_160_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_160_drvtbl;
	IF OBJECT_ID ('U_EEQFX_162_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_162_drvtbl;
	IF OBJECT_ID ('U_EEQFX_202_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_202_drvtbl;
	IF OBJECT_ID ('U_EEQFX_210_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_210_drvtbl;
	IF OBJECT_ID ('U_EEQFX_220_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_220_drvtbl;
	IF OBJECT_ID ('U_EEQFX_230_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_230_drvtbl;
	IF OBJECT_ID ('U_EEQFX_240_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_240_drvtbl;
	IF OBJECT_ID ('U_EEQFX_240cnt_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_240cnt_drvtbl;
	IF OBJECT_ID ('U_EEQFX_290_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_290_drvtbl;
	IF OBJECT_ID ('U_EEQFX_350_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_350_drvtbl;
	IF OBJECT_ID ('U_EEQFX_372_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_372_drvtbl;
	IF OBJECT_ID ('U_EEQFX_HDR_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_HDR_drvtbl;
	IF OBJECT_ID ('U_EEQFX_I9LocHeader_drvtbl') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_I9LocHeader_drvtbl;
	IF OBJECT_ID ('U_EEQFX_tEarnCode') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_tEarnCode;
	IF OBJECT_ID ('U_EEQFX_tTermReason') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_tTermReason;
	IF OBJECT_ID ('U_EEQFX_tCountry') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_tCountry;
	IF OBJECT_ID ('U_EEQFX_tEEStatCd') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_tEEStatCd;
	IF OBJECT_ID ('U_EEQFX_tPayFreq') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_tPayFreq;
	IF OBJECT_ID ('U_EEQFX_tEEType') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_tEEType;
	IF OBJECT_ID ('U_EEQFX_CurGenNumbers') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_CurGenNumbers;
	IF OBJECT_ID ('U_EEQFX_HistGenNumbers') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_HistGenNumbers;
	IF OBJECT_ID ('U_EEQFX_History') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_History;
	IF OBJECT_ID ('U_EEQFX_Earns') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_Earns;
	IF OBJECT_ID ('U_EEQFX_YTDEarns') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_YTDEarns;
	IF OBJECT_ID ('U_EEQFX_YTDTax') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_YTDTax;
	IF OBJECT_ID ('U_EEQFX_CuryrWages') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_CuryrWages;
	IF OBJECT_ID ('U_EEQFX_Deds') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_Deds;
	IF OBJECT_ID ('U_EEQFX_Taxes') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_Taxes;
	IF OBJECT_ID ('U_EEQFX_EmpComp') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_EmpComp;
	IF OBJECT_ID ('U_EEQFX_EmpComp_Use') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_EmpComp_Use;
	IF OBJECT_ID ('U_EEQFX_Years23') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_Years23;
	IF OBJECT_ID ('U_EEQFX_HistGenNumbers2') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_HistGenNumbers2;
	IF OBJECT_ID ('U_EEQFX_GET_NET') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_GET_NET;
	IF OBJECT_ID ('U_EEQFX_LastPayDate') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_LastPayDate;
	IF OBJECT_ID ('U_EEQFX_COIDList_Exclude') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_COIDList_Exclude;
	IF OBJECT_ID ('U_EEQFX_WorkLocs') IS NOT NULL
		DROP TABLE dbo.U_EEQFX_WorkLocs;


	--------
	-- Create the EmpInfo table - this will be populated with configurable field data below
	--------

	IF OBJECT_ID ('U_EEQFX_EMPINFO') IS NULL
		CREATE TABLE dbo.U_EEQFX_EMPINFO (
			varEEID CHAR(12), 
			varCOID  CHAR(5),
			varCoCode VARCHAR(15),
			varEmplID VARCHAR(20),
			varUserID VARCHAR(100),
			varAcctNO VARCHAR(100), 
			VarPIN  VARCHAR(100), 
			VarDirectLogin VARCHAR(100), 
			VarDivision VARCHAR(100),
			VarJobTitle VARCHAR(100),
			varAdjDateofHire datetime, 
			varTCIID VARCHAR(100),
			varDept  VARCHAR(100),
			varLocation VARCHAR(100)
		);

 
	---------
	-- Make sure the table is empty
	----------

	Delete dbo.U_EEQFX_EMPINFO;



	/********************************************
	GET VALUES FROM CONFIG TABLE THAT ARE USED BELOW
	*********************************************/

	DECLARE @cDepartment VARCHAR(100),
			@cDivision VARCHAR(100),
			@cEmplID VARCHAR(100),
			@cHireDate VARCHAR(100),
			@clocation VARCHAR(100),
			@cPin VARCHAR(100),
			@cUserID VARCHAR(100),
			@cJobTitle VARCHAR(100),
			@cAdjHireDate VARCHAR(100),
			@cCustom CHAR(1),
			@vUseSpecChars CHAR(1),
			@csplitfiles CHAR(1),
			@vCoCode VARCHAR(100),
			@vTermdays INT,
			@vExclComp VARCHAR(100),
			@vUCXAcctNo VARCHAR(100),
			@vTCIID  VARCHAR(100),
			@vVersion VARCHAR(100),
			@vSourceID VARCHAR(100),
			@vSourceType VARCHAR(100),
			@v_string VARCHAR(4000) ;

	SET @cDepartment=	dbo.dsi_fnConfig(@FormatCode,'cDepartment');
	SET @cDivision =	dbo.dsi_fnConfig(@FormatCode,'cDivision');
	SET @cEmplID =		dbo.dsi_fnConfig(@FormatCode,'cEmplID');
	SET @cHireDate =	dbo.dsi_fnConfig(@FormatCode,'cHireDate');
	SET @clocation=		dbo.dsi_fnConfig(@FormatCode,'clocation');
	SET @cPin =			dbo.dsi_fnConfig(@FormatCode,'cPin');
	SET @cUserID =		dbo.dsi_fnConfig(@FormatCode,'cUserID');
	SET @cJobTitle =	dbo.dsi_fnConfig(@FormatCode,'cJobTitle'); 
	SET @cAdjHireDate=	dbo.dsi_fnConfig(@FormatCode,'cAdjHireDate');
	SET @cCustom =		dbo.dsi_fnConfig(@FormatCode,'cCustom');
	SET @vUseSpecChars=	dbo.dsi_fnConfig(@FormatCode,'vUseSpecChars');
	
	SET @vCoCode =		dbo.dsi_fnVariable(@FormatCode,'vCoCode');
	SET @vTermdays =	dbo.dsi_fnVariable(@FormatCode,'vTermdays');
	SET @vExclComp =	ISNULL(dbo.dsi_fnVariable(@FormatCode,'vCoExcl'),'');
	SET @vUCXAcctNo=	dbo.dsi_fnVariable(@FormatCode,'vUCXAcctNo');
	SET @vTCIID =		dbo.dsi_fnVariable(@FormatCode,'vTCIID'); 
	SET @vVersion =		dbo.dsi_fnVariable(@FormatCode,'vVersiON');
	SET @vSourceID =	dbo.dsi_fnVariable(@FormatCode,'vSourceID');
	SET @vSourceType =	dbo.dsi_fnVariable(@FormatCode,'vSourceType');



	/********************************************
	Build coid/equifax company cross reference table
	*********************************************/

	SELECT
		eqcEquifaxCo = COALESCE(transvalue,@vCoCode),
		eqcCOID = CmpCoID,
		eqcCompanyCode = CmpCompanyCode

	INTO	dbo.U_EEQFX_Coid_Equifaxco  
	FROM	dbo.Company WITH (NOLOCK) 
	LEFT JOIN dbo.U_dsi_Translations_v2 WITH (NOLOCK) on formatcode = @FormatCode AND transcode = 'vCoCode' AND srcvalue = cmpcompanycode ;



	/********************************************
	GET VALUES FROM CONFIG TABLE THAT ARE USED TO
	  Build Companies to Exclude

	*********************************************/

	SELECT excccode = item, 
	  exccoid = cmpcoid

	INTO dbo.U_EEQFX_COIDList_Exclude
	FROM dbo.fn_ListToTable(@vExclComp)
	JOIN company on cmpcompanycode = item;

	/********************************************
	CREATE TABLE WITH DATA ELEMENTS - HEADER

	*********************************************/

	SELECT 
	drvVersiON = @vVersion,
	drvSourceID = @vSourceID,
	drvSourceType = @vSourceType,
	drvCode = 'R',
	drvSourceservice = SPACE(5)
	INTO dbo.U_EEQFX_HDR_drvtbl;


	--=================
	-- TRIM values in U_dsi_translations_v2 in case they have a space at the beginning or end
	--=================
	UPDATE dbo.U_dsi_translations_v2
	SET		
		FormatCode = LTRIM(RTRIM(FormatCode))
		,TransCode = LTRIM(RTRIM(TransCode))
		,SrcValue = LTRIM(RTRIM(SrcValue))
		,TransValue = LTRIM(RTRIM(TransValue)) ;

		-- select * from dbo.U_dsi_translations_v2

	/********************************************
	CREATE TABLE WITH EARNING CODES

	Uses U_dsi_translations_v2 table - X beside 
	earning means don't use
	*********************************************/

	SELECT * 
	INTO dbo.U_EEQFX_tEarnCode
	FROM dbo.U_dsi_translations_v2
	WHERE formatcode = @FormatCode
	AND transcode = 'tEarnCode'
	AND transvalue <> 'X';

	/********************************************
	CREATE TABLE WITH TERM REASONS

	Uses U_translations table - X beside 
	term reason means don't use
	*********************************************/

	SELECT * 
	INTO dbo.U_EEQFX_tTermReason
	FROM dbo.U_dsi_translations_v2
	WHERE formatcode = @FormatCode
	AND transcode = 'tUCXtermreason'
	AND transvalue <> 'X';

	/********************************************
	CREATE TABLE WITH COUNTRY TRANSLATIONS

	Uses U_translations table - X beside 
	country means don't use
	*********************************************/

	SELECT * 
	INTO dbo.U_EEQFX_tCountry
	FROM dbo.U_dsi_translations_v2
	WHERE formatcode = @FormatCode
	AND transcode = 'tCountry'
	AND transvalue <> 'X';

	/********************************************
	CREATE TABLE WITH STATUS CODES

	Uses U_translations table - X beside 
	status code means don't use
	*********************************************/

	SELECT * 
	INTO dbo.U_EEQFX_tEEStatCd
	FROM dbo.U_dsi_translations_v2
	WHERE formatcode = @FormatCode
	AND transcode = 'tEEStatCd'
	AND transvalue <> 'X';

	/********************************************
	CREATE TABLE WITH PAY FREQUENCY

	Uses U_translations table - X beside 
	pay frequency means don't use
	*********************************************/

	SELECT * 
	INTO dbo.U_EEQFX_tPayFreq
	FROM dbo.U_dsi_translations_v2
	WHERE formatcode = @FormatCode
	AND transcode = 'tPayFreq'
	AND transvalue <> 'X';

	/********************************************
	CREATE TABLE WITH EE TYPE

	Uses U_translations table - X beside 
	EE type means don't use
	*********************************************/

	SELECT * 
	INTO dbo.U_EEQFX_tEEType
	FROM dbo.U_dsi_translations_v2
	WHERE formatcode = @FormatCode
	AND transcode = 'tEEType'
	AND transvalue <> 'X';

	--Get Current Year Wages (paid in the current calendar year) Group by Talx company by employee, by ulti company
	SELECT DISTINCT
	 cyrequifaxco = eqcequifaxco,
	 cyreeid = pehEEID, 
	 cyrcoid = pehcoid,
	 cyr_wages = SUM(pehCurAmt),
	 cyr_Hours = SUm(PehCurHrs) 

	INTO dbo.U_EEQFX_CuryrWages
	FROM pEarHist WITH (NOLOCK)
	JOIN dbo.U_EEQFX_Coid_Equifaxco on pehcoid = eqccoid
	where SUBSTRING(pehPercontrol, 1, 4) = SUBSTRING(CONVERT(VARCHAR(10), @EndPerControl, 112), 1, 4)
	and not exists(SELECT 1 FROM dbo.U_EEQFX_COIDList_Exclude
	   where exccoid = pehcoid)
	GROUP BY pehEEID, pehcoid, eqcequifaxco
	having sum(pehcuramt) > 0;

	/********************************************
	Build EEList_EQUIFAXCO - currently keeping all non-terms and
	terms in current year or prior terms that were paid in year by Equifax Company
	*********************************************/

	SELECT distinct
	 efxequifaxco = eqcequifaxco,
	 efxeeid = xeeid,
	 efxcoid = xcoid

	INTO dbo.U_EEQFX_EEList_EquifaxCo 
	FROM dbo.U_EEQFX_EEList
	JOIN dbo.U_EEQFX_Coid_Equifaxco on xcoid = eqccoid;



	/********************************************
	Clean EEList TABLE - currently keeping all non-terms and
	terms in current year or prior terms that were paid in year by equifax company
	*********************************************/

	-- step 1:

	delete	dbo.U_EEQFX_EEList_EquifaxCo 
	from	dbo.U_EEQFX_EEList_EquifaxCo 
	join	empcomp WITH (NOLOCK)
			on	efxeeid = eeceeid 
			and efxcoid = eeccoid
	LEFT JOIN dbo.u_dsi_translations_v2 WITH (NOLOCK) 
			on	formatcode = @FormatCode 
			and transcode = 'vTermDays' 
			and srcvalue = efxequifaxco
	where 
			eecemplstatus = 'T' AND 
			eecdateoftermination < getdate() - COALESCE(transvalue,@vtermdays)
			and not exists (	SELECT 1 FROM dbo.U_EEQFX_CuryrWages
								where efxeeid = cyreeid AND 
								efxcoid = cyrcoid AND 
								efxequifaxco = cyrequifaxco);

	-- step 2:

	delete	dbo.U_EEQFX_EEList_EquifaxCo 
	from	dbo.U_EEQFX_EEList_EquifaxCo 
	join	empcomp t WITH (NOLOCK) 
			on	efxeeid = eeceeid 
			and efxcoid = eeccoid
	where 
			t.eecemplstatus = 'T'
			and exists(	SELECT 1 FROM empcomp a 
						JOIN dbo.U_EEQFX_Coid_Equifaxco 
						on a.eeccoid = eqccoid
						where a.eeceeid = t.eeceeid 
						and  eqcequifaxco = efxequifaxco
						and a.eecemplstatus <> 'T');


	-- step 3:  (used to be step 4)

	delete	dbo.U_EEQFX_EEList_EquifaxCo 
	from	dbo.U_EEQFX_EEList_EquifaxCo a
	join	emppers WITH (NOLOCK) 
			on efxeeid = eepeeid
	join	dbo.U_EEQFX_Coid_Equifaxco 
			on eephomecoid = eqccoid
	where 
			eephomecoid <> efxcoid AND 
			efxequifaxco = eqcequifaxco
	and exists(	SELECT 1 FROM dbo.u_EEQFX_eelist_EquifaxCo b 
				where a.efxeeid = b.efxeeid 
				and a.efxequifaxco = b.efxequifaxco
				having count(*) > 1);


	-- step 4: 

	/** 9/8/2015 LynnM  This used to be step 3. Switched run positions to correct issue: WHEN an employee is terminated in multiple companies,
	this SQL was deleteing all employee records including the most current record that had pay history ***/

	delete	dbo.U_EEQFX_EEList_EquifaxCo 
	from	dbo.U_EEQFX_EEList_EquifaxCo a
	JOIN (	SELECT esheeid eeid, eqcequifaxco equifaxco, max(eshstatusstartdate) maxdate
			FROM emphstat WITH (NOLOCK)
			JOIN dbo.U_EEQFX_Coid_Equifaxco 
			on eshcoid = eqccoid
			where eshemplstatus = 'A'
			group by esheeid, eqcequifaxco) esh 
		on	a.efxeeid = eeid 
		and efxequifaxco = equifaxco
	join	emphstat WITH (NOLOCK) 
			on	esheeid = efxeeid 
			and eshstatusstartdate = maxdate 
			and eshemplstatus = 'A'
	where 
			efxcoid <> eshcoid AND 
			efxequifaxco = equifaxco
	and exists(	SELECT 1 FROM dbo.u_EEQFX_eelist_EquifaxCo b 
				where a.efxeeid = b.efxeeid AND a.efxequifaxco = b.efxequifaxco
				having count(*) > 1);


	if @cCustom = 'Y' 

	Begin
	exec dbo.dsi_sp_BuildDriverTables_EEQFX_Custom 'EELIST';
	END

	--Get Last Pay Date of As Of Date

	SELECT prgeeid AS Payeeid, prgcoid AS Paycoid, eqcequifaxco payequifaxco, MAX(prgpaydate) AS payLastPayDate
	INTO dbo.U_EEQFX_LastPayDate
	FROM dbo.U_EEQFX_EEList_EquifaxCo 
	JOIN payreg WITH (NOLOCK) on prgeeid = efxeeid AND prgcoid = efxcoid
	JOIN dbo.U_EEQFX_Coid_Equifaxco on prgcoid = eqccoid
	where not exists(SELECT 1 FROM dbo.U_EEQFX_COIDList_Exclude
	   where exccoid = prgcoid)
	GROUP BY prgeeid, prgcoid, eqcequifaxco;



/********************************************
UPDATE CONFIGURABLE FIELDS
Populate the EmpInfo table here
*********************************************/

SELECT @v_string = '
 insert INTO dbo.U_EEQFX_EMPINFO (vareeid, varcoid, varcocode,
  varEmplID, varUserID, varAcctNO, VarPIN, VarDirectLogin, VarDivision, VarJobTitle,
  varAdjDateofHire, varTCIID, varDept, varLocation)
 SELECT efxeeid, efxcoid, efxequifaxco, ' +
  'COALESCE(emp.transvalue,' + @cEmplID + '), ' +
  'COALESCE(usr.transvalue,' + @cUserID + '), ' +
  'COALESCE(acct.transvalue,dbo.dsi_fnVariable(''EEQFX'', ''vUCXAcctNo'')) , ' +
  'COALESCE(pin.transvalue,' + @cPIN + '), ' +
  'COALESCE(dirlog.transvalue,dbo.dsi_fnVariable(''EEQFX'', ''vDirectLogin'')),' +
  'COALESCE(div.transvalue,' + @cDivision + '), '  +
  'COALESCE(titl.transvalue,' + @cJobTitle + '), ' + 
  'COALESCE(adj.transvalue,' + @cAdjHireDate + '), ' +
  'COALESCE(tci.transvalue,dbo.dsi_fnVariable(''EEQFX'', ''vTCIID'')) , ' +
  'COALESCE(dept.transvalue,' + @cDepartment + '), ' +
  'COALESCE(loc.transvalue,' + @cLocation + ') ' +

 'FROM dbo.U_EEQFX_EEList_EquifaxCo 
 JOIN empcomp WITH (NOLOCK) on efxeeid = eeceeid AND efxcoid = eeccoid
 JOIN emppers WITH (NOLOCK) on efxeeid = eepeeid
 JOIN company WITH (NOLOCK) on efxcoid = cmpcoid
 JOIN jobcode WITH (NOLOCK) on eecjobcode = jbcjobcode
 LEFT JOIN dbo.u_dsi_translations_v2 emp WITH (NOLOCK) on emp.formatcode = ''' + @FormatCode + ''' AND emp.Transcode = ''cEmplID'' AND emp.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 usr WITH (NOLOCK) on usr.formatcode = ''' + @FormatCode + ''' AND usr.Transcode = ''cUserID'' AND usr.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 acct WITH (NOLOCK) on acct.formatcode = ''' + @FormatCode + ''' AND acct.Transcode = ''vUCXAcctno'' AND emp.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 pin WITH (NOLOCK) on pin.formatcode = ''' + @FormatCode + ''' AND pin.Transcode = ''cPIN'' AND pin.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 dirlog WITH (NOLOCK) on dirlog.formatcode = ''' + @FormatCode + ''' AND dirlog.Transcode = ''vDirectLogin'' AND dirlog.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 loc WITH (NOLOCK) on loc.formatcode = ''' + @FormatCode + ''' AND loc.Transcode = ''cLocation'' AND loc.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 div WITH (NOLOCK) on div.formatcode = ''' + @FormatCode + ''' AND div.Transcode = ''cDivision'' AND div.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 titl WITH (NOLOCK) on titl.formatcode = ''' + @FormatCode + ''' AND titl.Transcode = ''cJobTitle'' AND titl.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 adj WITH (NOLOCK) on adj.formatcode = ''' + @FormatCode + ''' AND adj.Transcode = ''cAdjHireDate'' AND adj.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 tci WITH (NOLOCK) on tci.formatcode = ''' + @FormatCode + ''' AND tci.Transcode = ''vTCIID'' AND tci.srcvalue = efxequifaxco
 LEFT JOIN dbo.u_dsi_translations_v2 dept WITH (NOLOCK) on dept.formatcode = ''' + @FormatCode + ''' AND dept.Transcode = ''cDepartment'' AND dept.srcvalue = efxequifaxco';

 Print @v_string;
 EXEC(@v_string);


-------------
-- UPDATE the TCIID WHEN translations exist
-------------

UPDATE	dbo.U_EEQFX_EMPINFO
SET
		varTCIID=	TransValue	
		
FROM	dbo.U_EEQFX_EMPINFO WITH (NOLOCK)
JOIN	dbo.Company WITH (NOLOCK)
		ON	CmpCoID = varcoid
JOIN	dbo.U_dsi_Translations_v2 WITH (NOLOCK)
		ON	SrcValue = CmpCompanyCode
		AND TransCode = 'vTCIID'
		AND FormatCode = @FormatCode;


-------------
-- UPDATE the UCXAcctNo WHEN translations exist
-------------

UPDATE	dbo.U_EEQFX_EMPINFO
SET
		varAcctNO=	TransValue	
		
FROM	dbo.U_EEQFX_EMPINFO WITH (NOLOCK)
JOIN	dbo.Company WITH (NOLOCK)
		ON	CmpCoID = varcoid
JOIN	dbo.U_dsi_Translations_v2 WITH (NOLOCK)
		ON	SrcValue = CmpCompanyCode
		AND TransCode = 'vUCXAcctNo'
		AND FormatCode = @FormatCode;
		
		
/********************************************
CREATE TABLE which will determine which work address to use
*********************************************/

SELECT distinct
 wloccode = loccode,
 wloctype = CASE WHEN nullif(locaddressline1 + locaddresscity + locaddressstate + locaddresszipcode + locaddresscountry,'')  IS NULL THEN 'CMP' ELSE 'LOC' end

INTO dbo.U_EEQFX_WorkLocs
FROM location WITH (NOLOCK)
where exists (SELECT 1 FROM dbo.U_EEQFX_EEList_EquifaxCo
   JOIN empcomp WITH (NOLOCK) on efxeeid = eeceeid AND efxcoid = eeccoid AND loccode = eeclocation) ;
   

/********************************************
CREATE TABLE WITH DATA ELEMENTS - 202

Create the 202 record using data gathered 
and UPDATEd above.  Client will use one rectype or the other, however
the code below is used for both,  The layout AND sql clauses will
determine the format of the record being used.
*********************************************/

SELECT DISTINCT

 drvsubsort = cast('' as VARCHAR(32)),
 drveeid = eeceeid,
 drvcoid = eeccoid,
 drvCoCode = varcocode,
 drvSSN = eepssn,
 drvEmplID = varEmplID,
 drvUserID = varUserID,
 drvAcctNo = varAcctNo,
 drvAsofDate = CASE WHEN eecemplstatus = 'A' THEN CONVERT(VARCHAR(10), COALESCE(paylastpaydate,eecdateoflasthire), 112)
     WHEN eecemplstatus = 'T' THEN CONVERT(VARCHAR(10), COALESCE(paylastpaydate,eecdateoftermination), 112)
      ELSE  CONVERT(VARCHAR(10), COALESCE(paylastpaydate,eecemplstatusstartdate), 112) END,   -- should it be max?
 drvNameFirst = UPPER(eepnamefirst),
 drvNameMiddle = UPPER(SUBSTRING(eepnamemiddle, 1, 1)),
 drvNameLast = UPPER(eepnamelast),
 drvNameSuffix = nullif(UPPER(eepnamesuffix),'Z'),
 drvNamePrefix = nullif(UPPER(eepnameprefix),'Z'),
 drvPIN = varPIN,
 drvDirectLogin = varDirectLogin,
 drvDivision = varDivision,
 drvJobTitle = varJobTitle,
 drvEmplStatus = stat.transvalue,
 drvDateofLastHire = eecdateoflasthire,
 drvEEStatType = COALESCE(eetype.transvalue,eecfulltimeorparttime),
 drvDateofOrgHire = eecdateoforiginalhire,
 drvDateofTerm = CASE WHEN eecemplstatus = 'T' THEN eecDateOfTermination ELSE null END,
 drvtermreason = '',
 drvucxTermReason = CASE WHEN eecemplstatus in ('T') THEN trsn.TransValue ELSE space(10) END, 
 drvDateLastWorked = CASE WHEN eecemplstatus in ('T') THEN eecDateLastWorked ELSE null END,
 drvWorkState = CASE WHEN COALESCE(locaddresscountry,cmpaddresscountry) = 'USA' THEN COALESCE(locaddressstate,cmpaddressstate)
     ELSE space(2) END,
 drvWorklocation = varlocation,
 drvFEIN = space(6) + replace(cmpFedTaxID,'-',''),  -- space(15)
 drvSUIAcctNo = CtcIDNumber,  --space(15)
 drvAdjDateofHire = CASE WHEN nullif(varadjdateofhire,'') IS NULL AND eecDateOfLastHire <> eecDateOfOriginalHire THEN eecDateOfLastHire 
     WHEN nullif(varadjdateofhire,'') IS NOT NULL AND isdate(varadjdateofhire) = 1 THEN cast(varadjdateofhire as datetime)  ELSE null END,
 drvyrsofserv = space(3),
 drvmthofserv = space(2),
 drvPayFreq = freq.transvalue,
 drvtwn_add = space(1),
 drvucx_add = space(1),
 drv_add_ind_1 = 'U',
 drvaddrtype = 'HOME',
 drvAddressLine1 = UPPER(eepaddressline1),
 drvAddressLine2 = UPPER(eepaddressline2),
 drvAddressLine3 = space(60),
 drvCity = UPPER(eepaddresscity),
 drvState = CASE WHEN eepaddresscountry in ('USA','CAN') THEN UPPER(eepaddressstate)
    ELSE space(2) END,
 drvZipcode = CASE WHEN eepaddresscountry = 'USA'  AND LEN(eepaddresszipcode) = 9 THEN SUBSTRING(eepaddresszipcode, 1, 5) + '-' + SUBSTRING(eepaddresszipcode, 6, 4)
   WHEN eepaddresscountry = 'USA' THEN SUBSTRING(eepaddresszipcode,1,5)
   WHEN eepaddresscountry = 'CAN' THEN UPPER(SUBSTRING(eepaddresszipcode,1,3) + ' ' + SUBSTRING(eepaddresszipcode,4,3))
     ELSE space(16) END,
 drvCountry = COALESCE(ctry.TransValue,eepaddresscountry),
 drvCounty = space(20),
 drvprovince = CASE WHEN eepaddresscountry = 'CAN' THEN  eepaddressstate ELSE '' END,
 drvAdd_ind_2 = space(1),
 drvtype_2 = space(20),
 drvl1_2 = space(60),
 drvl2_2 = space(60),
 drvL3_2 = space(60),
 drvcity_2 = space(60),
 drvstate_2 = space(2),
 drvzip_2 = space(16),
 drvcountry_2 = space(2),
 drvcounty_2 = space(20),
 drvprovince_2 = space(64),
 drvAdd_ind_3 = space(1),
 drvtype_3 = space(20),
 drvl1_3 = space(60),
 drvl2_3 = space(60),
 drvL3_3 = space(60),
 drvcity_3 = space(60),
 drvstate_3 = space(2),
 drvzip_3 = space(16),
 drvcountry_3 = space(2),
 drvcounty_3 = space(20),
 drvprovince_3 = space(64),
 drvAdd_ind_4 = space(1),
 drvtype_4 = space(20),
 drvl1_4 = space(60),
 drvl2_4 = space(60),
 drvL3_4 = space(60),
 drvcity_4 = space(60),
 drvstate_4 = space(2),
 drvzip_4 = space(16),
 drvcountry_4 = space(2),
 drvcounty_4 = space(20),
 drvprovince_4 = space(64),
 drvphoneind = 'U',
 drvhomephonecountry = space(3),
 drvHomePhone = space(16),
 drvWork_phone_ind = space(1),
 drvWork_phone_country = space(3),
 drvWork_phone = space(16),
 drvWork_phone_ext = space(6),
 drvCell_phone_ind = space(1),
 drvCell_phone_country = space(3),
 drvCell_phone = space(16),
 drvPager_phone_ind = space(1),
 drvPager_phone_country = space(3),
 drvPager_phone = space(16),
 drvpager_pin = space(6),
 drvFax_phone_ind = space(1),
 drvFax_phone_country = space(3),
 drvFax_phone = space(16),
 drvFax_ext = space(6),
 drvOther_phone_ind = space(1),
 drvOther_phone_country = space(3),
 drvOther_phone = space(16),
 drvOther_phone_ext = space(6),
 drvemail_1 = space(256),
 drvemail_2 = space(256),
 drvemail_3 = space(256),
 drvemail_4 = space(256),
 drvemail_5 = space(256),
 drvemail_6 = space(256),
 drvmaritalstatus = space(1),
 drvgender = eepgender,
 drvdateofbirth = eepdateofbirth,
 drvemployer_def_1 = space(256),
 drvemployer_def_2 = space(256),
 drvemployer_def_3 = space(256),
 drvemployer_def_4 = space(256),
 drvemployer_log_def_1 = space(1),
 drvemployer_log_def_2 = space(1),
 drvemployer_log_def_3 = space(1),
 drvemployer_log_def_4 = space(1),
 drvignorebp = space(1), 
 drvTCIID = varTCIID,
 drvwotc_add = space(1),
 drvtics_add = space(1),
 drvtax_group_name = space(32),
 drvpay_process_begin_dt = null,
 drvDept = varDept

INTO dbo.U_EEQFX_202_drvtbl
FROM dbo.U_EEQFX_EMPINFO 
JOIN Empcomp WITH (NOLOCK)ON varcoid = eeccoid AND vareeid = eeceeid 
JOIN Emppers WITH (NOLOCK)ON eepeeid = eeceeid
JOIN company WITH (NOLOCK) ON cmpcoid = eeccoid
JOIN jobcode WITH (NOLOCK) ON jbcjobcode = eecjobcode
LEFT OUTER JOIN taxcode WITH (NOLOCK) ON CtcTaxCode = EecStateSUI AND CtcCOID = EecCOID
LEFT JOIN dbo.u_EEQFX_LastPayDate WITH (NOLOCK) ON Payeeid = eeceeid AND Paycoid = eeccoid
LEFT OUTER JOIN dbo.U_EEQFX_tTermReason trsn WITH (NOLOCK) ON eectermreason = trsn.srcvalue
LEFT OUTER JOIN dbo.U_EEQFX_tEEStatCd stat WITH (NOLOCK) ON eecemplstatus = stat.srcvalue
LEFT OUTER JOIN dbo.U_EEQFX_tEEType eetype WITH (NOLOCK) ON eeceetype = eetype.srcvalue 
LEFT OUTER JOIN dbo.U_EEQFX_tPayFreq freq WITH (NOLOCK) ON eecPayPeriod = freq.srcvalue 
LEFT OUTER JOIN dbo.U_EEQFX_tCountry ctry WITH (NOLOCK) ON ISNULL(nullif(eepaddresscountry,'Z'),'USA') = ctry.srcvalue
LEFT JOIN dbo.U_EEQFX_WorkLocs on wloccode = eeclocation AND wloctype = 'LOC'
LEFT JOIN location WITH (NOLOCK) ON Eeclocation = LocCode;


if @cCustom = 'Y' 

Begin
exec dbo.dsi_sp_BuildDriverTables_EEQFX_Custom '202';
End



/********************************************
CREATE TABLES FOR USE FOR 210 RECORD
*********************************************/

	/********************************************
	ANNUAL COLLECTION - YEARS 2 AND 3
	*********************************************/

	IF OBJECT_ID('U_EEQFX_Years23') IS NULL

	BEGIN 

		DECLARE @CurYear INT;
		SELECT @CurYear = YEAR(@enddate);
		
		PRINT 'ANNUAL COLLECTION FOR YEARS 2 AND 3 - @CurYear: ' + CONVERT(VARCHAR(4),@CurYear);


		---------
		--Get the gennumbers for One AND Two years ago
		---------
		SELECT 
			 PrgGenNumber
			,prgEEID 
			,prgcoid 
			,gnCoCode=	varcocode  
			,prgYear=	YEAR(prgPayDate) 
			,Y2Gen=		CASE WHEN SUBSTRING(prgPercontrol,1,4) = @CurYear - 1 THEN 'Y' ELSE 'N' END 
			,Y3Gen=		CASE WHEN SUBSTRING(prgPercontrol,1,4) = @CurYear - 2 THEN 'Y' ELSE 'N' END 
		INTO	dbo.U_EEQFX_HistGenNumbers2
		FROM	dbo.U_EEQFX_EMPINFO
		JOIN	dbo.iPayRegKeys (NOLOCK) on vareeid = prgeeid 
		JOIN	dbo.U_EEQFX_Coid_Equifaxco  on eqccoid = PrgCoID AND eqcequifaxco = varcocode
		WHERE NOT EXISTS (	SELECT 1 FROM dbo.U_EEQFX_COIDList_Exclude
							WHERE exccoid = prgcoid )
		AND SUBSTRING(prgPercontrol,1,4) BETWEEN @CurYear - 2 AND @CurYear - 1 ;

			-- select * from dbo.U_EEQFX_HistGenNumbers2

		---------
		--Get information from one and two years ago
		---------
		SELECT 
			 y23EEID=		prgEEID 
			,y23CoCode=		gnCoCode 
			,Year2_Year=	NULLIf(str(MAX(CASE WHEN ISNULL(Y2Gen,'') = 'Y' THEN prgYear END),4) + '0101', '0101') 
			,Year2_Base=	SUM(CASE WHEN ISNULL(Y2Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'R' THEN pehCurAmt ELSE 0 END) 
			,Year2_OT=		SUM(CASE WHEN ISNULL(Y2Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'O' THEN pehCurAmt ELSE 0 END) 
			,Year2_Bonus=	SUM(CASE WHEN ISNULL(Y2Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'B' THEN pehCurAmt ELSE 0 END) 
			,Year2_Comm=	SUM(CASE WHEN ISNULL(Y2Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'C' THEN pehCurAmt ELSE 0 END) 
			,Year2_Other=	SUM(CASE WHEN ISNULL(Y2Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue NOT IN('R','O','B','C','X') THEN pehCurAmt ELSE 0 END) 
			,Year2_Total=	SUM(CASE WHEN ISNULL(Y2Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue <> 'X' THEN pehCurAmt ELSE 0 END) 
			,Year3_Year=	NULLIf(str(MAX(CASE WHEN ISNULL(Y3Gen,'') = 'Y' THEN prgYear END),4) + '0101', '0101') 
			,Year3_Base=	SUM(CASE WHEN ISNULL(Y3Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'R' THEN pehCurAmt ELSE 0 END) 
			,Year3_OT=		SUM(CASE WHEN ISNULL(Y3Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'O' THEN pehCurAmt ELSE 0 END)
			,Year3_Bonus=	SUM(CASE WHEN ISNULL(Y3Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'B' THEN pehCurAmt ELSE 0 END) 
			,Year3_Comm=	SUM(CASE WHEN ISNULL(Y3Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'C' THEN pehCurAmt ELSE 0 END) 
			,Year3_Other=	SUM(CASE WHEN ISNULL(Y3Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue NOT IN('R','O','B','C','X') THEN pehCurAmt ELSE 0 END) 
			,Year3_Total=	SUM(CASE WHEN ISNULL(Y3Gen,'') = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue <> 'X' THEN pehCurAmt ELSE 0 END) 
			
		INTO	dbo.U_EEQFX_Years23
		FROM	dbo.U_EEQFX_HistGenNumbers2 WITH (NOLOCK)
		JOIN	dbo.PEarHist WITH (NOLOCK) ON pehGenNumber = prgGenNumber   
		JOIN	dbo.U_EEQFX_tEarnCode WITH (NOLOCK) ON pehEarnCode = dbo.U_EEQFX_tEarnCode.srcValue
		GROUP BY prgEEID, gncocode;

	END


	----------
	--SELECT GenNumbers based on percontrols selected (History)
	----------
	SELECT 
		prgGenNumber, 
		prgEEID, 
		prgcoid,
		varcocode gncocode,
		year(prgPayDate) prgYear, 
		'Y' Y1Gen
	INTO dbo.U_EEQFX_HistGenNumbers
	FROM dbo.U_EEQFX_EMPINFO 
	JOIN dbo.payReg WITH (NOLOCK) on vareeid = prgeeid 
	JOIN dbo.U_EEQFX_Coid_Equifaxco  on eqccoid = PrgCoID AND eqcequifaxco = varcocode
	WHERE 
		SUBSTRING(prgPercontrol,1,4) = SUBSTRING(@EndPerControl,1,4)
		AND prgPercontrol <= @EndPerControl
		AND NOT EXISTS (SELECT 1 FROM dbo.U_EEQFX_COIDList_Exclude where exccoid = prgcoid);


	CREATE INDEX idxHistTGNum ON dbo.U_EEQFX_HistGenNumbers(prgGenNumber, prgEEID, gncocode);


	----------
	--Get the current year, AND past two previous years information (using years23 FROM above)
	-- IF Year1 Total is 0, then do not create a 210 record for the employee.
	----------
	SELECT 
		hisEEID,
		hiscocode,
		Year1_Year,
		ISNULL(Year1_Base,0) Year1_Base,
		ISNULL(Year1_OT,0) Year1_OT,
		ISNULL(Year1_BONus,0) Year1_BONus,
		ISNULL(Year1_Comm,0) Year1_Comm,
		ISNULL(Year1_Other,0) Year1_Other,
		ISNULL(Year1_Total,0) Year1_Total,
		Year2_Year,
		ISNULL(Year2_Base,0) Year2_Base,
		ISNULL(Year2_OT,0) Year2_OT,
		ISNULL(Year2_BONus,0) Year2_BONus,
		ISNULL(Year2_Comm,0) Year2_Comm,
		ISNULL(Year2_Other,0) Year2_Other,
		ISNULL(Year2_Total,0) Year2_Total,
		Year3_Year,
		ISNULL(Year3_Base,0) Year3_Base,
		ISNULL(Year3_OT,0) Year3_OT,
		ISNULL(Year3_BONus,0) Year3_BONus,
		ISNULL(Year3_Comm,0) Year3_Comm,
		ISNULL(Year3_Other,0) Year3_Other,
		ISNULL(Year3_Total,0) Year3_Total

	INTO dbo.U_EEQFX_History
	FROM 
		(SELECT 
			 hisEEID=		drvEEID  
			,hiscocode=		drvCoCode 
			,Year1_Year=	NULLIf(str(MAX(CASE WHEN Y1Gen = 'Y' THEN prgYear END),4) + '0101','0101') 
			,Year1_Base=	SUM(CASE WHEN Y1Gen = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'R' THEN pehCurAmt ELSE 0 END) 
			,Year1_OT=		SUM(CASE WHEN Y1Gen = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'O' THEN pehCurAmt ELSE 0 END) 
			,Year1_Bonus=	SUM(CASE WHEN Y1Gen = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'B' THEN pehCurAmt ELSE 0 END) 
			,Year1_Comm=	SUM(CASE WHEN Y1Gen = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue = 'C' THEN pehCurAmt ELSE 0 END) 
			,Year1_Other=	SUM(CASE WHEN Y1Gen = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue NOT IN ('R','O','B','C','X') THEN pehCurAmt ELSE 0 END) -- 03/25/2016 LynnM
			,Year1_Total=	SUM(CASE WHEN Y1Gen = 'Y' AND dbo.U_EEQFX_tEarnCode.TransValue <> 'X' AND ISNULL(srcValue,'') <> '' THEN pehCurAmt ELSE 0 END) 
			
		FROM		dbo.U_EEQFX_202_drvtbl
		LEFT JOIN	dbo.U_EEQFX_HistGenNumbers WITH (NOLOCK) on drveeid = prgeeid AND drvcocode = gncocode
		LEFT JOIN	dbo.pEarHist WITH (NOLOCK) ON pehGenNumber = prgGenNumber  -- LynnM 2/23/16 updated FROM a JOIN to a LEFT JOIN
		LEFT OUTER JOIN dbo.U_EEQFX_tEarnCode WITH (NOLOCK) ON pehEarnCode = dbo.U_EEQFX_tEarnCode.srcValue
		GROUP BY drvEEID, drvcocode) peh		
	LEFT JOIN dbo.U_EEQFX_Years23 WITH (NOLOCK) ON hisEEID = y23EEID AND hiscocode = y23cocode
	WHERE Year1_Total <> 0 ;


	IF @cCustom = 'Y'
	Begin
		EXEC dbo.dsi_sp_BuildDriverTables_EEQFX_Custom 'UPDPAYHIST';
	End 



	/********************************************
	CREATE TABLE WITH DATA ELEMENTS - 210

	Create the 210 record using data gathered 
	and UPDATEd above
	*********************************************/

	SELECT DISTINCT
		drvSubSort=		cast('' as VARCHAR(32)),
		drvEEID=		drveeid,
		drvCOID=		drvcoid,
		drvCoCode=		drvcocode,
		drvSSN=			drvssn,
		drvEmplID=		drvEmplID,
		drvFEIN=		drvFEIN,
		drvDivision=	drvDivision,
		drvVerpay=		'Y',
		drvAsofDate=	CASE	WHEN eecemplstatus = 'A' AND paylastpaydate IS NOT NULL THEN CONVERT(VARCHAR(10), paylastpaydate, 112)
								WHEN eecemplstatus = 'A' AND paylastpaydate IS NULL THEN CONVERT(VARCHAR(10), eecdateoflasthire, 112) 
								WHEN eecemplstatus = 'T' AND paylastpaydate IS NOT NULL THEN CONVERT(VARCHAR(10), paylastpaydate, 112)
								WHEN eecemplstatus = 'T' AND paylastpaydate IS NULL THEN CONVERT(VARCHAR(10), eecDateOfTermination, 112) 
								WHEN eecemplstatus not in ('A','T') AND paylastpaydate IS NOT NULL THEN CONVERT(VARCHAR(10), paylastpaydate, 112)
								WHEN eecemplstatus not in ('A','T') AND paylastpaydate IS NULL THEN CONVERT(VARCHAR(10), eecemplstatusstartdate, 112) END,  
		drvAvgHours =	EecScheduledWorkHrs,
		drvreceiving =	'N',
		drvcarrier =	space(30),
		drvinjdate =	null,
		drvawarddate =	null,
		drvclaimpend =	'N',
		drvclaimno =	space(12),
		drvWrkLocAddress1= UPPER(COALESCE(locaddressline1,cmpaddressline1)),
		drvWrkLocAddress2= UPPER(CASE WHEN loccode IS NOT NULL THEN locaddressline2 ELSE cmpaddressline2 end),
		drvWrkLocCity=	UPPER(COALESCE(locaddresscity,cmpaddresscity)),
		drvWrkLocState= UPPER(nullif(COALESCE(locaddressstate,cmpaddressstate),'FN')),
		drvWrkLocZip=	CASE WHEN COALESCE(locaddresscountry,cmpaddresscountry) = 'USA' THEN left(COALESCE(locaddresszipcode,cmpaddresszipcode),5) + 
								CASE WHEN len(COALESCE(locaddresscountry,cmpaddresscountry)) = 9 
											THEN '-' + SUBSTRING(COALESCE(locaddresszipcode,cmpaddresszipcode),6,4) ELSE '' end
							 WHEN COALESCE(locaddresscountry,cmpaddresscountry) = 'CAN' Then
											UPPER(SUBSTRING(COALESCE(locaddresszipcode,cmpaddresszipcode),1,3) + ' ' +
											SUBSTRING(COALESCE(locaddresszipcode,cmpaddresszipcode),4,3))
							ELSE UPPER(COALESCE(locaddresszipcode,cmpaddresszipcode)) END,
		drvWrkLocCountry = ctry.transvalue,
		drvDept = drvdept,
		drvcompclasscode = space(6),
		drvUnioNMember = CASE WHEN nullif(COALESCE(nullif(eecunionlocal,'Z'),nullif(eecunionnational,'Z')),' ') IS NULL THEN 'N' ELSE 'Y' END,
		drvUnioNAffiliate = CASE WHEN nullif(COALESCE(nullif(eecunionlocal,'Z'),nullif(eecunionnational,'Z')),' ') IS NULL THEN space(15)
								 ELSE COALESCE(nullif(eecunionlocal,'Z'),nullif(eecunionnational,'Z')) END,
		drvnextincdate = null,
		drvnextincamt = space(11),
		drvlastincdate = null,
		drvlastincamt = space(11),
		drvcontemp = 'Y',
		drvcontot = 'N',
		drvcontbon = 'N',
		drvdaysmissed = space(4),
		drvLeaveStartDate = CASE WHEN eecEmplStatus = 'L' THEN eecEmplStatusStartDate ELSE null END,
		drvLeaveEndDate = CASE WHEN eecEmplStatus = 'L' THEN eecStatusExpectedENDDate ELSE null END,
		drvPayRate = CASE WHEN eecSalaryOrHourly = 'H' THEN eecHourlyPayRate ELSE eecAnnSalary END,
		drvPayRateCode = CASE WHEN eecSalaryOrHourly = 'H' THEN '09' ELSE '01' END,
		drvcvgtot = space(8),
		drvPayFreq = space(2),
		drvYear1Date = Year1_Year, 
		drvGrossBaseAmt1 = Year1_Base,
		drvGrossOTAmt1 = Year1_OT,
		drvBONusAmt1 = Year1_BONus,
		drvCommAmt1 = Year1_Comm,
		drvOtherAmt1 = Year1_Other,
		drvTotalAmt1 = Year1_Total, 
		drvYear2Date = Year2_Year,
		drvGrossBaseAmt2 = Year2_Base,
		drvGrossOTAmt2 = Year2_OT,
		drvBONusAmt2 = Year2_BONus,
		drvCommAmt2 = Year2_Comm,
		drvOtherAmt2 = Year2_Other,
		drvTotalAmt2 = Year2_Total,
		drvYear3Date = Year3_Year,
		drvGrossBaseAmt3 = Year3_Base,
		drvGrossOTAmt3 = Year3_OT,
		drvBONusAmt3 = Year3_BONus,
		drvCommAmt3 = Year3_Comm,
		drvOtherAmt3 = Year3_Other,
		drvTotalAmt3 = Year3_Total,
		drvAcctNo = drvAcctNo

	INTO dbo.U_EEQFX_210_drvtbl
	FROM dbo.U_EEQFX_202_drvtbl WITH (NOLOCK)
	JOIN dbo.EmpComp WITH (NOLOCK)ON drvcoid = eeccoid AND drveeid = eeceeid 
	JOIN dbo.Emppers WITH (NOLOCK)ON eepeeid = eeceeid
	JOIN dbo.company WITH (NOLOCK) ON cmpcoid = eeccoid
	LEFT OUTER JOIN dbo.U_EEQFX_History WITH (NOLOCK) ON eeceeid = hiseeid AND drvCoCode = hiscocode
	LEFT JOIN dbo.u_EEQFX_LastPayDate WITH (NOLOCK) ON Payeeid = eeceeid AND Paycoid = eeccoid
	LEFT JOIN dbo.location WITH (NOLOCK) ON Eeclocation = LocCode
	LEFT OUTER JOIN dbo.U_EEQFX_tCountry ctry WITH (NOLOCK) ON UPPER(COALESCE(locaddresscountry,cmpaddresscountry)) = ctry.srcvalue
	LEFT JOIN dbo.U_EEQFX_WorkLocs WITH (NOLOCK) on wloccode = eeclocation AND wloctype = 'LOC';


	UPDATE dbo.u_EEQFX_210_drvtbl
	SET drvYear1Date = SUBSTRING(CONVERT(VARCHAR(10), @EndDate, 112), 1, 4) + '0101'   -- SUBSTRING(CONVERT(VARCHAR(10), getdate(), 112), 1, 4) + '0101' 
	WHERE drvYear1Date IS NULL;


	DELETE FROM dbo.u_EEQFX_210_drvtbl
	WHERE (	ISNULL(drvtotalamt1,0) = 0
			AND ISNULL(drvtotalamt2,0) = 0
			AND ISNULL(drvtotalamt3,0) = 0);


	if @cCustom = 'Y' 

	Begin
	exec dbo.dsi_sp_BuildDriverTables_EEQFX_Custom '210';
	End



/******************************************** 
CREATE TABLES FOR USE FOR 220 RECORD
*********************************************/

--Get the GenNumbers based on percontrols SELECTed (current year)
SELECT 
 prgGenNumber, 
 prgPayDate, 
 prgPeriodStartDate, 
 prgPeriodendDate, 
 prgPercontrol, 
 prgEEID,
 prgcoid,
 drvcocode prgeqcocode
INTO dbo.U_EEQFX_CurGenNumbers
FROM dbo.U_EEQFX_202_drvtbl WITH (NOLOCK)
JOIN payReg (NOLOCK) on drveeid = prgeeid 
JOIN dbo.U_EEQFX_Coid_Equifaxco  on eqccoid = PrgCoID AND drvCoCode = eqcequifaxco
WHERE prgPercontrol BETWEEN @StartPerControl AND @EndPerControl
--AND prgcheckaddmode not in ('T','E') 
AND ( prgcheckaddmode not in ('T','E') AND ( prgCheckAddMode <> 'N' AND prgTotEarnAmt <> 0 ))  -- 01/06/2017 Add checkmode 'N' to exclusion list (accrual import) when total earn is 0
and not exists(SELECT 1 FROM dbo.U_EEQFX_COIDList_Exclude where exccoid = prgcoid);

if @cCustom = 'Y' 

Begin
exec dbo.dsi_sp_BuildDriverTables_EEQFX_Custom 'CURGEN';
End

-- insert in any checks for employee with same paydate AND period end date
--  this is because EQFX overwrites detail data received with same paydate AND period end date

insert INTO dbo.U_EEQFX_CurGenNumbers
SELECT distinct
 p.prgGenNumber, 
 p.prgPayDate, 
 p.prgPeriodStartDate, 
 p.prgPeriodendDate, 
 p.prgPercontrol, 
 p.prgEEID,
 p.PrgCoID,
 eqcequifaxco

FROM dbo.U_EEQFX_CurGenNumbers c
JOIN payreg p on c.prgeeid = p.prgeeid AND c.prgpaydate = p.prgpaydate AND c.prgperiodenddate = p.prgperiodenddate 
JOIN dbo.U_EEQFX_Coid_Equifaxco  on eqccoid = p.prgcoid AND prgeqcocode = eqcequifaxco
where not exists (SELECT 1 FROM dbo.U_EEQFX_CurGenNumbers d
   where d.prggennumber = p.prggennumber)
and not exists(SELECT 1 FROM dbo.U_EEQFX_COIDList_Exclude
   where exccoid = p.prgcoid);

create index idxCurTGNum ON dbo.U_EEQFX_CurGenNumbers(prgGenNumber, prgEEID, prgeqcocode);


--Get current year earnings information 
--(based on earnings codes defined AND configured in U_dsi_translations_v2)

SELECT 
 prgEEID pehEEID,
 prgeqcocode peheqcocode, 
 prgPayDate pehPayDate, 
 prgPeriodEndDate pehPeriodEndDate,
 SUM(pehCurAmt) All_Gross, 
 CONVERT(FLOAT, '') All_Net, 
 SUM(CASE WHEN pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 end) All_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'A' THEN pehCurAmt ELSE 0 END) AddlIncome_Gross,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'R' THEN pehCurAmt ELSE 0 END) Reg_Gross,
 0 Reg_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'R' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) Reg_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'O' THEN pehCurAmt ELSE 0 END) OT_Gross,
 0 OT_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'O' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) OT_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'V' THEN pehCurAmt ELSE 0 END) Vac_Gross,
 0 Vac_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'V' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) Vac_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'S' THEN pehCurAmt ELSE 0 END) Sick_Gross,
 0 Sick_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'S' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) Sick_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'H' THEN pehCurAmt ELSE 0 END) Hol_Gross,
 0 Hol_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'H' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) Hol_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'B' THEN pehCurAmt ELSE 0 END) BONus_Gross,
 0 BONus_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'B' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) BONus_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'E' THEN pehCurAmt ELSE 0 END) Sev_Gross,
 0 Sev_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'E' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) Sev_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'P' THEN pehCurAmt ELSE 0 END) Pens_Gross,
 0 Pens_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'P' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) Pens_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'W' THEN pehCurAmt ELSE 0 END) Wage_Gross,
 0 Wage_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'W' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) Wage_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'K' THEN pehCurAmt ELSE 0 END) WComp_Gross,
 0 WComp_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'K' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) WComp_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'C' THEN pehCurAmt ELSE 0 END) Comm_Gross,
 0 Comm_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'C' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) Comm_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'T' THEN pehCurAmt ELSE 0 END) Tips_Gross,
 0 Tips_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'T' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) Tips_Hours,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'M' THEN pehCurAmt ELSE 0 END) MISc_Gross,
 0 MISc_Net,
 SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'M' AND pehexclintotalhours <> 'Y' THEN pehCurHrs ELSE 0 END) MISc_Hours
INTO dbo.U_EEQFX_Earns
FROM dbo.U_EEQFX_CurGenNumbers (NOLOCK)
JOIN pEarHist (NOLOCK) ON pehGenNumber = prgGenNumber 
JOIN dbo.u_EEQFX_tearncode (NOLOCK) ON pehEarnCode = dbo.u_EEQFX_tearncode.srcValue
GROUP BY prgEEID, prgeqcocode, prgPayDate, prgPeriodEndDate;


SELECT p.PrgEEID, prgeqcocode, SUM(p.PrgNetAmt) AS NET, p.PrgPayDate, p.prgPeriodEndDate
INTO dbo.U_EEQFX_GET_NET
FROM payreg p
JOIN dbo.U_EEQFX_CurGenNumbers c on c.PrgGenNumber = p.prggennumber 
GROUP BY p.PrgEEID, prgeqcocode, p.PrgPayDate, p.PrgPeriodEnddate;


UPDATE dbo.u_EEQFX_Earns
SET All_Net = NET
FROM dbo.U_EEQFX_Earns
JOIN dbo.U_EEQFX_GET_NET on PrgEEID = PehEEID  AND prgeqcocode = peheqcocode 
where prgpaydate = pehpaydate 
and prgperiodenddate = pehperiodenddate;

--Get current year deduction information
SELECT 
 prgEEID pdhEEID,
 prgeqcocode pdheqcocode, 
 prgPayDate pdhPayDate,
 PrgPeriodEndDate pdhPeriodEndDate,
 SUM(CASE WHEN pdhTaxCategory in ('125','D125','132','FSA','DFSA') THEN pdhEECurAmt ELSE 0 END) D125,
 SUM(CASE WHEN pdhisdefcomp = 'Y' THEN pdhEECurAmt ELSE 0 END) D401K,
 SUM(CASE WHEN pdhDedType = 'GAR' THEN pdhEECurAmt ELSE 0 END) DGar,
 SUM(CASE WHEN pdhDedType <> 'GAR' and
    pdhtaxcategory not in  ('125','D125','132','FSA','DFSA')
    AND pdhisdefcomp <> 'Y' THEN pdhEECurAmt ELSE 0 END) DOther
INTO dbo.U_EEQFX_Deds
FROM dbo.U_EEQFX_CurGenNumbers (NOLOCK)
JOIN ipDedHist (NOLOCK) ON pdhGenNumber = prgGenNumber 
GROUP BY prgEEID, prgeqcocode, prgPayDate, prgPeriodEndDate;


--Get current year tax informatiON
SELECT 
 prgEEID pthEEID,
 prgeqcocode ptheqcocode, 
 prgPayDate pthPayDate,
 prgPeriodEndDate PthPeriodEndDate,
 SUM(CASE WHEN pthTypeOfTax = 'FIT' THEN pthCurTaxAmt ELSE 0 END) USFIT_CurTaxAmt,
 SUM(CASE WHEN pthTypeOfTax = 'SIT' THEN pthCurTaxAmt ELSE 0 END) SIT_CurTaxAmt,
 SUM(CASE WHEN pthTypeOfTax = 'LIT' AND pthISEmployerTax = 'N' THEN pthCurTaxAmt ELSE 0 END) LIT_CurTaxAmt,  --SUM(CASE WHEN pthTypeOfTax = 'LIT' THEN pthCurTaxAmt ELSE 0 END) LIT_CurTaxAmt,
 SUM(CASE WHEN pthTypeOfTax = 'SOC' AND pthISEmployerTax = 'N' THEN pthCurTaxAmt ELSE 0 END) SOC_CurTaxAmt,
 SUM(CASE WHEN pthTypeOfTax = 'MED' AND pthISEmployerTax = 'N' THEN pthCurTaxAmt ELSE 0 END) MED_CurTaxAmt,
 SUM(CASE WHEN pthTaxCode like '%SUIER' THEN pthCurTaxableGross ELSE 0 END) SUI_GrossWages
INTO dbo.U_EEQFX_Taxes
FROM dbo.U_EEQFX_CurGenNumbers (NOLOCK)
JOIN ipTaxHist (NOLOCK) ON pthGenNumber = prgGenNumber 
GROUP BY prgEEID, prgeqcocode, prgPayDate, PrgPeriodEndDate;


if @cCustom = 'Y' 

Begin
exec dbo.dsi_sp_BuildDriverTables_EEQFX_Custom 'UPDPAYDATA';
End


/********************************************
CREATE TABLE WITH DATA ELEMENTS - 220

Create the 220 record using data gathered 
AND UPDATEd above
*********************************************/

SELECT DISTINCT
 drvsubsort = cast(CONVERT(VARCHAR(10),prgpaydate,112) as VARCHAR(32)),
 drveeid = drveeid,
 drvcoid = drvcoid,
 drvCoCode = drvcocode, 
 drvSSN = eepssn,
 drvEmplID = drvEmplID,
 drvDivision = drvDivision,
 drvPayFreq = drvPayFreq,
 drvFEIN = drvFEIN,
 drvSUIAcctNo = CtcIDNumber,
 drvWrkState = CASE WHEN LocAddressCountry = 'USA' THEN LocAddressState
     WHEN LocAddressCountry <> 'USA' THEN eepaddressstate END,
 drvWrkLoc = drvWorkLocation,
 drvWrkCountry = ctry.transvalue,
 drvCafe = D125,
 drvPensiON = Pens_Gross,
 drvAddIncome = AddlIncome_Gross,
 drv401K = D401K,
 drvFedTax = USFIT_CurTaxAmt,
 drvStateTax = SIT_CurTaxAmt,
 drvLocalTax = LIT_CurTaxAmt,
 drvFICATax = SOC_CurTaxAmt,
 drvMedCrTax = MED_CurTaxAmt,
 drvGarn = DGAR,
 drvOthWITH = DOTHER,
 drvENDDate = prgPeriodENDDate,
 drvBegDate = prgPeriodStartDate,
 drvPayDate = prgPayDate,
 drvSUIGross = SUI_GrossWages,
 drvPayTypeA = 'A',
 drvGrossPayA = CASE WHEN All_Gross IS NULL THEN 0 ELSE All_Gross END,
 drvNetPayA = CASE WHEN All_Net IS NULL THEN 0 ELSE All_Net END,
 drvHoursA = CASE WHEN All_Hours IS NULL THEN 0 ELSE All_Hours END,
 drvInHouseNum = drvAcctno,
 drvPayTypeR = 'R',
 drvGrossPayR = Reg_Gross,
 drvNetPayR = Reg_Net,
 drvHoursR = Reg_Hours,
 drvPayTypeO ='O',
 drvGrossPayO = OT_Gross,
 drvNetPayO = OT_Net,
 drvHoursO = OT_Hours,
 drvPayTypeV = 'V',
 drvGrossPayV = Vac_Gross,
 drvNetPayV = Vac_Net,
 drvHoursV = Vac_Hours,
 drvPayTypeS = 'S',
 drvGrossPayS = Sick_Gross,
 drvNetPayS = Sick_Net,
 drvHoursS = Sick_Hours,
 drvPayTypeH = 'H',
 drvGrossPayH = Hol_Gross,
 drvNetPayH = Hol_Net,
 drvHoursH = Hol_Hours,
 drvPayTypeB ='B',
 drvGrossPayB = BONus_Gross,
 drvNetPayB = BONus_Net,
 drvHoursB = BONus_Hours,
 drvPayTypeE = 'E',
 drvGrossPayE = Sev_Gross,
 drvNetPayE = Sev_Net,
 drvHoursE = Sev_Hours,
 drvPayTypeP = 'P',
 drvGrossPayP = Pens_Gross,
 drvNetPayP = Pens_Net,
 drvHoursP = Pens_Hours,
 drvPayTypeW = 'W',
 drvGrossPayW = Wage_Gross,
 drvNetPayW = Wage_Net,
 drvHoursW = Wage_Hours,
 drvPayTypeK ='K',
 drvGrossPayK = WComp_Gross,
 drvNetPayK = WComp_Net,
 drvHoursK = WComp_Hours,
 drvPayTypeC = 'C',
 drvGrossPayC = Comm_Gross,
 drvNetPayC = Comm_Net,
 drvHoursC = Comm_Hours,
 drvPayTypeT = 'T',
 drvGrossPayT = Tips_Gross,
 drvNetPayT = Tips_Net,
 drvHoursT = Tips_Hours,
 drvPayTypeM = 'M',
 drvGrossPayM = MISc_Gross,
 drvNetPayM = MISc_Net,
 drvHoursM = MISc_Hours
INTO dbo.U_EEQFX_220_drvtbl
FROM dbo.U_EEQFX_202_drvtbl WITH (NOLOCK) 
JOIN EmpComp WITH (NOLOCK)ON drvcoid = eeccoid AND drveeid = eeceeid 
JOIN Emppers WITH (NOLOCK)ON eepeeid = eeceeid
JOIN company WITH (NOLOCK) ON cmpcoid = eeccoid
JOIN location WITH (NOLOCK) ON loccode = eeclocation
JOIN (SELECT * FROM TaxCode (NOLOCK)
WHERE ctcHasBeenReplaced = 'N' AND ctcEffectiveDate <= GETDATE()
AND ctcEffectiveStopDate >= GETDATE()) taxcode ON ctcTaxCode = eecStateSUI AND ctcCOID = eecCOID
JOIN (SELECT  prgeeid, prgeqcocode, min(prgperiodstartdate) prgperiodstartdate,
  prgperiodenddate, prgpaydate FROM dbo.U_EEQFX_CurGenNumbers
  group by prgeeid, prgpaydate, prgperiodenddate, prgeqcocode) cur  ON eecEEID = prgEEID AND drvCoCode = prgeqcocode
LEFT OUTER JOIN dbo.U_EEQFX_Taxes (NOLOCK) ON prgEEID = pthEEID AND prgPayDate = pthPayDate AND prgPeriodEndDate = pthPeriodEndDate AND ptheqcocode = drvcocode
LEFT OUTER JOIN dbo.U_EEQFX_Deds (NOLOCK) ON prgEEID = pdhEEID AND prgPayDate = pdhPayDate AND PrgPeriodEndDate = pdhPeriodEndDate AND pdheqcocode = drvcocode
LEFT OUTER JOIN dbo.U_EEQFX_Earns (NOLOCK) ON prgEEID = pehEEID AND prgPayDate = pehPayDate AND prgPeriodEndDate = pehPeriodEndDate AND peheqcocode = drvcocode
LEFT OUTER JOIN dbo.U_EEQFX_tCountry ctry WITH (NOLOCK) ON locAddressCountry = ctry.srcvalue;

if @cCustom = 'Y' 

Begin
exec dbo.dsi_sp_BuildDriverTables_EEQFX_Custom '220';
End



	/********************************************
	IF CLIENT IS USING BENEFIT RECORDS CALL THE MODULE
	*********************************************/
	if (SELECT 1 FROM U_dsi_sqlclauses where RTRIM(formatcode) = @FormatCode
	  AND RTRIM(ISNULL(left(whereclause,6),'')) <> 'IGNORE'
	  AND RTRIM(recordset) = 'D23') = 1 

	BEGIN
		EXEC dbo.dsi_sp_BuildDriverTables_EEQFX_Custom 'BENEFITS';
	END



/********************************************
IF CLIENT IS USING WOTC
CREATE TABLES FOR USE FOR 290 RECORD
*********************************************/

	IF (SELECT 1 FROM dbo.U_dsi_SQLClauses where RTRIM(FormatCode) = @FormatCode
		AND RTRIM(ISNULL(LEFT(WhereClause,6),'')) <> 'IGNORE'
		AND RTRIM(RecordSet) = 'D29') = 1
	BEGIN

		SELECT 
			 eytdEEID=			PehEEID 
			,eytdEqCoCode=		gncocode 
			,eytdLocation=		p.PrgLocation 
			,eytdLastPayDate=	MAX(PrgPayDate) 
			,eytdPeriodEndDate=	MAX(PrgPeriodEndDate) 
			,YTD_Hours=			SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue in ('R','O')  AND PehExclInTotalHours <> 'Y' THEN pehCurHrs ELSE 0 END) 
			,YTD_Tips=			SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue = 'T' THEN pehCurAmt ELSE 0 END) 
			,YTD_Wages=			SUM(CASE WHEN dbo.u_EEQFX_tearncode.TransValue in ('R','O') THEN pehCurAmt ELSE 0 END) 
			
		INTO	dbo.U_EEQFX_YTDEarns
		FROM	dbo.U_EEQFX_HistGenNumbers g
		JOIN	dbo.PayReg p on p.prgeeid = g.prgeeid AND p.prggennumber = g.prggennumber 
		JOIN	dbo.PEarHist ON p.prggennumber = pehgennumber 
		JOIN	dbo.u_EEQFX_tearncode ON pehEarnCode = dbo.u_EEQFX_tearncode.srcValue
		GROUP BY pehEEID, gncocode,  p.prglocation;


		SELECT 
			 tytdEEID=		pthEEID  
			,tytdEqCoCode=	gncocode 
			,tytdLocation=	p.prglocation 
			,YTD_FUTA=		SUM(CASE WHEN PthTaxCode ='USFUTA' THEN (PthCurTaxableWages + PthCurExcessWages) ELSE 0 END) 
			,YTD_EIC=		SUM(CASE WHEN PthTaxCode ='USAEIC' THEN PthCurTaxAmt ELSE 0 END) 
			
		INTO	dbo.U_EEQFX_YTDTax
		FROM	dbo.U_EEQFX_HistGenNumbers g WITH (NOLOCK)
		JOIN	dbo.PayReg p WITH (NOLOCK) ON p.PrgEEID = g.PrgEEID AND p.PrgGenNumber = g.PrgGenNumber 
		JOIN	dbo.pTaxHist WITH (NOLOCK) ON p.PrgGenNumber = PthGenNumber
				AND pthtaxcode in ('USFUTA','USAEIC')
		GROUP BY pthEEID, gncocode, p.PrgLocation;


		---------
		--  Delete when YTD FUTA WAGES is NOT GREATER THAN 0
		--  03/27/2016  PER Equifax 
		---------

		DELETE	dbo.U_EEQFX_YTDTax
		FROM	dbo.U_EEQFX_YTDTax
		WHERE
				YTD_FUTA <= 0 ; 



		--------
		-- Create the 290 record
		--------
		
		SELECT DISTINCT
			drvSubSort =		CAST('' as VARCHAR(32)),
			drvEEID =			EecEEID,
			drvCompanyCode=		RTRIM(CmpCompanyCode),
			drvCoCode =			eytdEqCoCode,
			drvTCIID =			varTCIID,
			drvSSN =			eepSSN,
			drvLocation =		RTRIM(CmpCompanyCode) + eytdLocation,
			drvLocationNumber=	eytdLocation,
			drvDateOfHire =		EecDateOfOriginalHire,
			drvLastCheckDate=	dbo.fn_EEQFX_datemin(@enddate,
								CASE	WHEN EecEmplStatus = 'A' AND eytdLastPayDate IS NOT NULL THEN CONVERT(VARCHAR(10), eytdLastPayDate, 112)
										WHEN EecEmplStatus = 'A' AND eytdLastPayDate IS NULL THEN CONVERT(VARCHAR(10), EecDateOfLastHire, 112) 
										WHEN EecEmplStatus = 'T' AND eytdLastPayDate IS NOT NULL THEN CONVERT(VARCHAR(10), eytdLastPayDate, 112)
										WHEN EecEmplStatus = 'T' AND eytdLastPayDate IS NULL THEN CONVERT(VARCHAR(10), EecDateOfTermination, 112) 
										WHEN EecEmplStatus not in ('A','T') AND eytdLastPayDate IS NOT NULL THEN CONVERT(VARCHAR(10), eytdLastPayDate, 112)
										WHEN EecEmplStatus not in ('A','T') AND eytdLastPayDate IS NULL THEN CONVERT(VARCHAR(10), EecEmplStatusStartDate, 112) end),  

			drvYTDHours =		CASE WHEN ISNULL(YTD_Hours,0) > 0 THEN YTD_Hours ELSE 0 END,
			drvYTDTips =		0,
			drvYTDEIC =			0,
			drvYTDWages =		0,  --  SET TO 0 Per Equifax 3/27/2016  -- CASE WHEN ISNULL(ytd_wages,0) > 0 THEN ytd_wages ELSE 0 END,
			drvYTDFUTA =		YTD_FUTA, 
			drvFEIN =			space(6) + replace(cmpFedTaxID,'-',''),
			drvLegalEntityName=	RTRIM(CmpCompanyName),
			drvPerEndDate =		eytdPeriodEndDate,
			drvHourlyRate =		EecHourlyPayRate

		INTO	dbo.U_EEQFX_290_drvtbl
		FROM	dbo.U_EEQFX_EMPINFO 
		JOIN	dbo.u_EEQFX_YTDEarns b on eytdeeid = vareeid  AND eytdeqcocode = varcocode
		JOIN	dbo.EmpComp ON eeceeid = eytdeeid AND eeccoid = varcoid
		JOIN	dbo.EmpPers ON eepeeid = eeceeid
		JOIN	dbo.U_EEQFX_YTDTax ON tytdeeid = eytdeeid  AND tytdeqcocode = varcocode AND tytdlocation = eytdlocation
		JOIN	dbo.Location WITH (NOLOCK) ON eytdlocation = LocCode
		JOIN	dbo.Company WITH (NOLOCK) ON varcoid = cmpcoid
		WHERE
				ISNULL(ytd_futa,0) > 0 AND Locaddresscountry = 'USA'
				and not exists (SELECT 1 FROM dbo.u_dsi_translations_v2 
								where formatcode = @FormatCode 
								AND transcode = 'SkipRecord' AND varcocode = srcvalue AND transvalue = 'D290');


		-- select * from dbo.U_EEQFX_290_drvtbl
		

		IF @cCustom = 'Y' 
		Begin
			EXEC dbo.dsi_sp_BuildDriverTables_EEQFX_Custom '290';
		End ;



		/********************************************
		CREATE TABLES FOR USE FOR 140 RECORD

		*********************************************/

		SELECT DISTINCT
			 drvSubSort =			cast('' as VARCHAR(32))
			,drvEEID =				SPACE(15)
			,drvCompanyCode =		drvCompanyCode
			,drvCoCode =			drvCoCode
			,drvTCIID =				drvTCIID
			,drvLocation =			drvLocation
			,drvLocationNumber=		drvLocationNumber
			,drvLocationName =		drvLegalEntityName   -- LocDesc,  3/28/2016 Per Equifax, this must be the Legal Enity Name for the FEIN
			,drvLocAddressline1=	LocAddressLine1
			,drvLocAddressline2=	LocAddressLine2
			,drvLocAddresscity=		LocAddressCity
			,drvLocAddressstate=	LocAddressState
			,drvLocAddresszipcode=	CASE WHEN LEN(LocAddressZipcode) = 5 THEN LocAddressZipcode
										 WHEN LEN(LocAddresszipcode) = 9 THEN SUBSTRING(LocAddressZipcode, 1, 5) + '-' + SUBSTRING(LocAddressZipcode, 6, 4) END
			,drvLocAddresscountry=	COALESCE(l.transvalue,locaddresscountry)
			,drvFEIN =				right(drvFEIN,10)
			,drvLocationStatus =	CASE WHEN LocISInactive = 'Y' THEN 'C' ELSE 'O' END
			,drvLocPhoneNumber =	LocPhoneMainNumber
			,drvRptLvl1 =			space(10)
			,drvRptLvl2 =			space(10)
			,drvRptLvl3 =			space(10)
			,drvRptLvl4 =			space(10)
			,drvRptLvl5 =			space(10)
			,drvRptLvl6 =			space(10)
			,drvRptLvl7 =			space(10)
			,drvRptLvl8 =			space(10)
			,drvLocBeginDate =		cast(CASE	WHEN ISDATE(LocImportCode) = 0 THEN '19010101'
												WHEN LEN(LocImportCode) < 8 THEN '19010101'
												ELSE LocImportCode end as datetime)
			,drvLocInactiveDate =	LocInactiveDate
			,drvLocNAICS =			space(6)

		INTO	dbo.U_EEQFX_140_drvtbl
		FROM	dbo.U_EEQFX_290_drvtbl WITH (NOLOCK)
		JOIN	dbo.Location WITH (NOLOCK) ON drvLocationNumber = LocCode
		LEFT OUTER JOIN dbo.U_EEQFX_tCountry l WITH (NOLOCK) ON ISNULL(nullif(LocAddressCountry,'Z'),'USA') = l.srcvalue;


		IF @cCustom = 'Y' 
		Begin
			EXEC dbo.dsi_sp_BuildDriverTables_EEQFX_Custom '140';
		End

		END

		/********************************************
		IF CLIENT IS USING I-9 RECORDS CALL THE MODULE - RecordSet D35 must be Y
		*********************************************/

		if (SELECT 1 FROM u_dsi_sqlclauses where RTRIM(formatcode) = 'EEQFX' 
		  AND RTRIM(ISNULL(left(whereclause,6),'')) <> 'IGNORE'
		  AND RTRIM(recordset) = 'D35') = 1 AND @cCustom = 'Y'

		BEGIN

		exec dbo.dsi_sp_BuildDriverTables_EEQFX_Custom 'I-9';

		END

		/********************************************
		 SET THE FILE NAME (set in after collect
		*********************************************/

		/********************************************
		 Last Chance to call the custom code module
		*********************************************/

		if @cCustom = 'Y' 

		Begin
		exec dbo.dsi_sp_BuildDriverTables_EEQFX_Custom 'FINAL';
		End


END




/*********

dbo.dsi_sp_TestSwitchbox_v2 'EEQFX', 'EEQFX'
dbo.dsi_sp_TestSwitchbox_v2 'EEQFX', 'ZAP'


Alter View [dbo].[dsi_vwEEQFX_Export] as
        SELECT top 2000000 Data FROM dbo.U_EEQFX_File WITH (NOLOCK)
  where recordset not in ('H97','D16','D90','D91','T98')
       order by case SUBSTRING(RecordSet,1,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END,
   InitialSort, cast(SUBSTRING(RecordSet,2,2) as int),subsort

GO
CREATE View [dbo].[dbo.dsi_vwEEQFX_Export_I9Loc] as
        SELECT top 2000000 Data FROM dbo.U_EEQFX_File  WITH (NOLOCK)
  where recordset  in ('H97','D16','D90','D91','T98')
       order by case SUBSTRING(RecordSet,1,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END,
   InitialSort, cast(SUBSTRING(RecordSet,2,2) as int),subsort
GO


SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEQFX%'
ORDER BY AdfSetNumber, AdfFieldNumber

********/


GO
If OBJECT_ID('dsi_sp_AfterCollect_EEQFX') IS NOT NULL DROP PROCEDURE dbo.dsi_sp_AfterCollect_EEQFX;
GO

/****** Object:  StoredProcedure [dbo].[dsi_sp_AfterCollect_EEQFX]    Script Date: 03/28/2016 13:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[dsi_sp_AfterCollect_EEQFX]
as

/*** Please note some clients have different Equifax company codes (drvcocode). 
 In such case data needs to be summed within the Equifax company. Also, client
may have different files created based on Equifax company. 
 There may also be override parameters or translations in u_dsi_translation_v2 to use.
If recordsets are in the translations, they are to not be processed, so query should not create 
records in the table.

A separate file(s) must be created if a client uses the I9 Location reporting

There is a variable in the configuration to indicate if separate files are need by equifax company

Revision History
-----------------
Updated By		Date		Desc   
Lynn Manning	10/06/2015	Update file grouping
Lynn Manning	03/17/2016	Remove function dsi_fnGetExportPath as not all new databases have that installed
								and use dsi_fnVariable to get file path instead


*************/
BEGIN

    DECLARE @FormatCode char(10);
    SELECT  @FormatCode = 'EEQFX';

    DECLARE  @ExportCode char(10)
			,@exportpath  varchar(100)
			,@filename  varchar(200)
			,@scmd varchar(4000)
			,@testing char(1)
			,@vUseSpecChars char(1)
			,@vsplitFiles char(1)
			,@vMainCoCode varchar(10) ;

	SET @vUseSpecChars = dbo.dsi_fnVariable(@formatcode,'vUseSpecChars');
	SET @vSplitFiles = dbo.dsi_fnVariable(@formatcode,'vSplitFiles');
	SET @vMainCoCode = dbo.dsi_fnVariable(@formatcode,'vCoCode')  ;

    DECLARE
		@v_Servername varchar (32),
		@dbname  varchar (30),
		@query  varchar (4000),
		@Result  int,
		@eqfxco  varchar(20),
		@filetype  varchar(5);


	-- THESE VARIABLES ADDED TO ALLOW MORE AUTOMATION TO PROCESS
	SELECT	@v_ServerName = '"' + rtrim(@@SERVERNAME) + '"',
			@dbname = rtrim(db_name()),
			@exportcode = exportcode
	from dbo.U_dsi_Parameters with (nolock)
	where FormatCode = @FormatCode;

	-- split files if needed  also send with special characters if required


	-- File Path
	IF @ExportCode LIKE 'TEST%'
	BEGIN
		SELECT @ExportPath = ltrim(rtrim(IsNull(dbo.dsi_fnVariable(@FormatCode, 'TestPath'),'')));
	END;
	
	IF @ExportCode IN ('ONDEMAND','SCHEDULED')
	BEGIN
		SELECT @ExportPath = CASE WHEN dbo.dsi_fnVariable('EEQFX','vFileType') = 'T' THEN ltrim(rtrim(IsNull(dbo.dsi_fnVariable(@FormatCode, 'TestPath'),'')))
				  	WHEN dbo.dsi_fnVariable('EEQFX','vFileType') = 'P' THEN ltrim(rtrim(IsNull(dbo.dsi_fnVariable(@FormatCode, 'ExportPath'),'')))
					END;
	END;

	IF ISNULL(@ExportPath,'') = '' 
	BEGIN
		SELECT @ExportPath = ltrim(rtrim(IsNull(dbo.dsi_fnVariable(@FormatCode, 'ExportPath'),'')));
	END;
	
	
	IF RIGHT(@ExportPath,1) <> '\'
	BEGIN
		SELECT @ExportPath = RTRIM(@ExportPath) + '\' ;
	END;
    		
	-- select @ExportPath = ltrim(rtrim(IsNull(dbo.dsi_fnGetExportPath(@FormatCode, @exportcode),'')))  -- commented out 3/28/16 


	BEGIN

		DECLARE EQFXfile CURSOR FAST_FORWARD FOR

		SELECT distinct 
			case when isnull(@vSplitFiles,'N') = 'N' then rtrim(@vMainCoCode) else rtrim(subsort2) end, -- @eqfxco
			case when coalesce(transvalue,dbo.dsi_fnVariable('EEQFX','vFileType')) = 'T' or @exportcode like 'TEST%' then 'TST' else 'PROD' end 
		FROM dbo.U_EEQFX_File
		LEFT JOIN dbo.u_dsi_translations_v2 ftype with (nolock) 
				on ftype.formatcode = @formatcode and ftype.Transcode = 'vFileType' and ftype.srcvalue = rtrim(subsort2) and isnull(@vSplitFiles,'N') = 'Y'
		WHERE LEFT(RecordSet ,1) = 'D'

		OPEN EQFXfile

		FETCH NEXT FROM EQFXFile INTO @eqfxco, @filetype

		WHILE @@FETCH_STATUS = 0
		BEGIN

		SELECT @Query = 'select top 200000000  Data  from ' + @dbname + '.dbo.U_EEQFX_File with (nolock) ' +
				'where recordset not in (''H97'',''D16'',''D90'',''D91'',''T98'') and (left(recordset,1) in(''H'',''T'') or rtrim(Subsort2) = ''' 
				+  @eqfxco +  ''' or isnull(''' + @vSplitFiles +  ''',''N'') = ''N'' )' + 
          ' order by case substring(RecordSet,1,1) when ''H'' then 1 when ''D'' then 2 else 3 end, Subsort2, InitialSort, cast(substring(RecordSet,2,2) as int),subsort'

		select @filename = @eqfxco + @filetype + 'in.msf'

		select @sCmd = 'BCP "'  +  @query + '" QueryOut "' + @ExportPath + @FileName + '" -o "' + @ExportPath + 'ExportLog.txt"' + 
						' -S ' + @v_ServerName + ' -T -c -t' + case when isnull(@vUseSpecChars,'N') = 'Y' then ' -C RAW' 
						else '' end

		print @scmd

		EXEC @Result = master.dbo.xp_cmdshell @sCmd , NO_OUTPUT


		----------
		-- Build I9 Location File if 160 record being used
		----------
		
		IF (	select 1 from u_dsi_sqlclauses where rtrim(formatcode) = 'EEQFX' 
				and rtrim(isnull(left(whereclause,6),'')) <> 'IGNORE'
				and rtrim(recordset) = 'D16') = 1
		BEGIN

			select @Query = 'select top 200000000  Data  from ' + @dbname + '.dbo.U_EEQFX_File with (nolock) ' +
				'where recordset in (''H97'',''D16'',''D90'',''D91'',''T98'') and (left(recordset,1) in(''H'',''T'') or rtrim(Subsort2) = ''' 
				+  @eqfxco +  ''' or isnull(''' + @vSplitFiles +  ''',''N'') = ''N'' )' + 
				' order by case substring(RecordSet,1,1) when ''H'' then 1 when ''D'' then 2 else 3 end, Subsort2, InitialSort, cast(substring(RecordSet,2,2) as int),subsort'

			print @query

			select @filename =   @eqfxco + case when @filetype = 'TST' then '_i9test_' else '_i9prod_' end 
									+ replace(convert(varchar(10),getdate(),101),'/','')
									+ '_userloc.i9'

			select @sCmd = 'bcp "' + @query + '" queryout "' + @ExportPath + @FileName 
							+ '" -o "' + @ExportPath + 'ExportLog.txt"' + ' -T -S' + @v_ServerName + ' -c -t '


			EXEC @Result = master.dbo.xp_cmdshell @sCmd  --, NO_OUTPUT
			
		END

		FETCH NEXT FROM EQFXfile INTO @eqfxco , @filetype
	
	END 

	CLOSE EQFXfile
	DEALLOCATE EQFXfile
	END

END




