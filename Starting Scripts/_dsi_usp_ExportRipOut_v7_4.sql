SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[_dsi_usp_ExportRipOut_v7_4]
    (
      @FormatCode    VARCHAR(10),
      @AllObjects    CHAR(1)      = 'Y',
      @FilePath      VARCHAR(500) = '',
      @IsWeb         CHAR(1)      = '',
      @NewFormatCode VARCHAR(10)  = ''
    )
AS
SET NOCOUNT ON;
/* _____________________________________________________________________________

Created By:       Joe Parolin
Create Date:      03/13/2013

Purpose:          Generate a full deployment script for a custom SQL Interface

Revision History
---------------------------------------------
Update By           Date            Desc
N Wetherbee         04/15/2014      Revise code that generates create-table scripts
N Wetherbee         04/28/2014      Set dbo. prefixes when needed.  Update dbo.Custom_Quotename script
N Wetherbee         10/24/2014      Fix issue that occurred when multiple AscDefH records encountered with same FormatCode. Also added default for @AllObjects
N Wetherbee         03/19/2015      Replaced reference to with fn_ListToTable dsi_BDM_fn_ListToTable function. Initialized @PKNAME variable.
N Wetherbee         03/26/2015      Applied fix to allow functions to be ripped properly.  Added reference to translation table from v2 switchbox
C Donovan           10/19/2015      1) Fixed SQL extract for Asc tables to use dbo.Custom_Quotename function
                                    2) Enforce ORDER BY on dsi tables, for readability
                                    3) Pull AdhPreProcessSQL SP when it's not standard naming or switchbox
                                    4) Only delete and insert meaningful tables
C Donovan           02/04/2016      1) Add additional UKG tables
                                    2) Clean up SP for readability
                                    3) Fix varchar(max) to show varchar(max) instead of varchar(-1)
                                    4) Add Table Functions and Inlined Table Function retrieval
                                    5) Ensure all terminators present and adheres to ANSI-Standards
                                    6) Replace tabs with SPACE(4) in output, since results-to-grid does not output tabs, this will reduce
                                       SPs being ripped out flush left when all tabs are replaced with only one space
C Donovan           02/11/2016      Update @AllObjects = 'N' flag to exclude from creating export-specific tables, except _File
C Donovan           02/16/2016      1) Drop ##SQLObjects outside of dynamic query
                                    2) Update MM version in same ripout
C Donovan           10/30/2016      Add new optional parameter @IsWeb to add UltiPro Delivery (Mid-Market) functionality
C Donovan           04/10/2017      1) Use varchar(8000) instead of varchar(1000) for certain column variables
                                    2) Insert dbo.fn_GetTimedKey() for expSystemID and AdhModifyStamp so they are recreated upon redeploy
                                    3) Update expAscFileName to set the folder/filename at deploy point when @IsWeb = 'Y'
                                    4) Update expAscFileName to "File Name is Auto Generated" when @IsWeb = 'N'
C Donovan           04/16/2017      1) Fix UD naming convention for expAscFileName
                                    2) Enable @IsWeb for Enterprise by setting correct expAscFileName
                                    3) Change logic to update U_dsi_Configuration for @IsWeb in the ripout, instead of directly to the db before ripping out
C Donovan           08/13/2017      Add INSERT INTO dbo.CustomTemplates table for @IsWeb = 'Y'
C Donovan           02/22/2018      Remove line that was setting the expAscFileName incorrectly in PHX environments
C Donovan           03/30/2108      1) Drop SavePath table at top to clear potential errors
                                    2) Clean up ripout so unused portions do not show up (e.g. variables for environment paths when a path doesn't exist)
C Donovan           10/24/2018      Ensured IDENTITY columns, such as AuditKey, are not being ripped out
C Donovan           04/10/2019      1) Update Web filename convention
                                    2) Update CustomTemplates to only include the EMPEXPORT engine (so the BENEFITIMP record does not get applied when interface is import)
                                    3) Insert dbo.fn_GetTimedKey() for impSytemID so it is recreated upon redeploy
John Transier       08/09/2020      0> Version 6
                                    1> Added flower box and Git commands
                                    2> Added section dividers
                                    3> Added NewFormatCode parm; generates new AscDefF/AscDefH SystemIDs for easier cloning
                                    4> SavePath now works for both web and BO exports; all target paths are restored, including NULL paths
                                    5> Only ExportPath and TestPath are NULLed for web exports
                                    6> Generates a warning if the @IsWeb variable doesn't match the current project, e.g. @IsWeb = Y but the project appears to be Back Office.
                                    7> Ignores stored procs with a 'G10_BKP_2020' suffix as these were backups created by the orgCode expansion
John Transier       01/05/2021      0> Version 7
                                    1> Added permanent table dbo.U_dsi_RipoutParms; removed SavePath table
                                    2> Cloned ripouts now blank the COID list and data selectors
                                    3> AscExp expSystemIDs are now saved off and restored to prevent ghost jobs for existing scheduled export sessions
                                    4> @IsWeb parameter is now required
                                    5> Minor fixes
Lynn Manning        04/19/2021      0> Pull the latest SR# for the Git flowerbox command
John Transier       07/14/2021      0> Version 7.3
                                    1> Added "End ripout" comment
                                    2> Removed Git commands
                                    3> Moved "delete configuration" section out of loop to make for simpler editing
John Transier       08/23/2021      0> Version 7.4
                                    1> Modified AscDefH/AscDefF commands to handle AscDefH and AscDefF turning into views
                                    2> Drops the (no longer used) SavePath table if it exists 


NOTES
-----

The second, third, and fourth parameters are optional. If left blank (or only @FormatCode is explicitly set), then all objects will be deployed, and output will send to query/out.
EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBCCOBRA';

If the first two parameters are set (or @FormatCode and @FilePath are explicitly set) then procedure will deploy all objects to file path specified.
EXEC dbo._dsi_usp_ExportRipOut 'EDISCCOBRA', '\\EZ2SUP4DB01\UltiProData\ChrisD\Exports\';

The third parameter determines whether to include all objects.
   'Y' (DEFAULT) will CREATE for all objects (anything with %FormatCode% included in object name).
   'N' will not CREATE each object. Only the required ones (U_FormatCode_File). The objects will then be recreated the first time the interface runs in the environment.
   EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBCCOBRA', @AllObjects = 'N'; -- Redeploy - custom tables U_FORMATCODE_Perm_% or U_FORMATCODE_%map% are not rebuilt if they exist or populated
   EXEC dbo._dsi_usp_ExportRipOut 'ESAGE',DEFAULT,'Y'; -- Deploy ALL (no objects exist in new environment)

The fourth parameter sets the @IsWeb flag. This defaults to 'N', and if set to 'Y' then the proper U_dsi_Configuration updates will be made upon deployment.
EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISCCOBRA', @FilePath = '\\EZ2SUP4DB01\UltiProData\Vinny\Exports', @IsWeb = 'Y';

_____________________________________________________________________________*/

BEGIN


-----------
-- Sanitize variables
-----------

SET @FormatCode    = LTRIM(RTRIM(ISNULL(@FormatCode, '')))
SET @AllObjects    = LTRIM(RTRIM(ISNULL(@AllObjects, '')))
SET @FilePath      = LTRIM(RTRIM(ISNULL(@FilePath, '')))
SET @IsWeb         = LTRIM(RTRIM(ISNULL(@IsWeb, '')))
SET @NewFormatCode = LTRIM(RTRIM(ISNULL(@NewFormatCode, '')))


-----------
-- Check formatcode in target system
-----------

SET @FormatCode = UPPER(RTRIM(@FormatCode));

IF (SELECT COUNT(1) FROM dbo.AscDefH WHERE AdhFormatCode = @FormatCode) = 0 BEGIN
   SELECT 'FormatCode ' + @FormatCode + ' doesn''t exist in this system.'
   GOTO EndProgram
END


-----------
-- Check whether IsWeb is populated
-----------

IF @IsWeb NOT IN ('Y', 'N') BEGIN
   SELECT 'Please set the IsWeb variable to Y or N.'
   GOTO EndProgram
END


-----------
-- Drop ##SQLObjects in case one exists with non-ANSI column names
-----------

IF OBJECT_ID('tempdb.dbo.##SQLObjects') IS NOT NULL DROP TABLE dbo.##SQLObjects;


-----------
-- Add final \ to @FilePath if not included
-----------

IF RTRIM(@FilePath) <> '\' AND LEN(@FilePath) > 1 SET @FilePath = RTRIM(@FilePath) + '\';


-----------
-- Create Custom_Quotename Function If It Doesn't Exist
-----------

IF OBJECT_ID('Custom_Quotename') IS NULL BEGIN
    EXEC(
    'CREATE FUNCTION [dbo].[Custom_Quotename] (@Val varchar(8000), @Quote varchar(25))
' + 'RETURNS varchar(8000) AS
    BEGIN
        IF (@Val IS NULL)
            RETURN NULL;
        IF (@Quote IS NULL)
            SET @Quote = '''';

        RETURN @Quote + REPLACE(@Val,'''''''','''''''''''') + @Quote;
    END;
    ');
END;


-----------
-- Declare Variables
-----------

DECLARE @ARNumber         VARCHAR(7)
DECLARE @CRLF             CHAR(2)
DECLARE @Cnt              INT
DECLARE @COID             VARCHAR(5)
DECLARE @ColumnNames      NVARCHAR(MAX)
DECLARE @ColumnValues     NVARCHAR(MAX)
DECLARE @DelLoop          INT
DECLARE @FileName         VARCHAR(500)
DECLARE @FilePathName     VARCHAR(8000)
DECLARE @FromDB           SYSNAME
DECLARE @IsExport         INT
DECLARE @ObjectCnt        INT
DECLARE @MainLoop         INT
DECLARE @ObjectID         NVARCHAR(100)
DECLARE @ObjectName       VARCHAR(100)
DECLARE @ObjectType       VARCHAR(2)
DECLARE @PKNAME           VARCHAR(100)
DECLARE @Project          VARCHAR(50)
DECLARE @QuotedFormatCode VARCHAR(12)
DECLARE @SQLStmnt         NVARCHAR(MAX)
DECLARE @SRNumber         VARCHAR(64)
DECLARE @Tab              CHAR(1)
DECLARE @DSI_TableList    VARCHAR(8000)
DECLARE @UseFileName      VARCHAR(1)
DECLARE @WhereConds       VARCHAR(8000)
DECLARE @Temp             VARCHAR(256)


-- @TblSQL houses the SQL statements to put into @Script

DECLARE @TblSQL AS table (s varchar(8000), id int IDENTITY);

-- @Script houses the ripout text

DECLARE @Script AS table (SQLRecId int IDENTITY, SQLStmt varchar(max));


-----------
-- Set Variables
-----------

SET @CRLF             = CHAR(13) + CHAR(10)
SET @Tab              = CHAR(9)
SET @FromDB           = DB_NAME();
SET @MainLoop         = 1;
SET @DelLoop          = 1;
SET @ObjectCnt        = 0;
SET @IsExport         = 0;
SET @DSI_TableList    = 'U_dsi_Configuration,U_dsi_SQLClauses,U_dsi_Translations,U_dsi_Translations_v2,U_dsi_Translations_v3,U_dsi_RecordSetDetails,AscDefF,AscDefH,AscExp,AscImp';
SET @FileName         = @FormatCode + '_DeployScript' + CONVERT(CHAR(8) ,GETDATE(), 112) + '.sql';
SET @FilePathName     = RTRIM(NULLIF(@FilePath,'')) + @FileName;
SET @UseFileName      = ISNULL(dbo.dsi_fnVariable(@FormatCode, 'UseFileName'), 'Y');
SET @QuotedFormatCode = CHAR(39) + @FormatCode + CHAR(39)


-- Why the SELECT DISTINCT 1?

-- SET NOCOUNT ON

INSERT INTO @Script (SQLStmt)
SELECT 'SET NOCOUNT ON;'
FROM (SELECT DISTINCT 1 E FROM dbo.AscExp WITH (NOLOCK)
       WHERE expFormatCode = @FormatCode) EXP;


-----------
-- Drop the SavePath table if it exists
-----------

INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('-- Drop the SavePath table if it exists')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('IF OBJECT_ID(''U_' + @FormatCode + '_SavePath'') IS NOT NULL DROP TABLE dbo.U_' + @FormatCode + '_SavePath')
INSERT INTO @Script VALUES ('')


-----------
-- Create U_dsi_RipoutParms if it doesn't exist
-----------

INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('-- Create U_dsi_RipoutParms if it doesn''t exist')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('IF OBJECT_ID(''U_dsi_RipoutParms'') IS NULL BEGIN')
INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('   CREATE TABLE dbo.U_dsi_RipoutParms (')
INSERT INTO @Script VALUES ('   rpoFormatCode  VARCHAR(10)   NOT NULL,')
INSERT INTO @Script VALUES ('   rpoParmType    VARCHAR(64)   NOT NULL,')
INSERT INTO @Script VALUES ('   rpoParmValue01 VARCHAR(1024) NULL,')
INSERT INTO @Script VALUES ('   rpoParmValue02 VARCHAR(1024) NULL,')
INSERT INTO @Script VALUES ('   rpoParmValue03 VARCHAR(1024) NULL,')
INSERT INTO @Script VALUES ('   rpoParmValue04 VARCHAR(1024) NULL,')
INSERT INTO @Script VALUES ('   rpoParmValue05 VARCHAR(1024) NULL')
INSERT INTO @Script VALUES (')')
INSERT INTO @Script VALUES ('END')
INSERT INTO @Script VALUES ('')



-----------
--Clear U_dsi_RipoutParms
-----------

INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('-- Clear U_dsi_RipoutParms')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('')



-----------
-- Add paths to U_dsi_RipoutParms
-----------

IF @NewFormatCode = '' BEGIN

   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('-- Add paths to U_dsi_RipoutParms')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02)')
   INSERT INTO @Script VALUES ('SELECT')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('FormatCode,')
   INSERT INTO @Script VALUES ('''Path'',')
   INSERT INTO @Script VALUES ('CfgName,')
   INSERT INTO @Script VALUES ('CfgValue')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('FROM dbo.U_Dsi_Configuration')
   INSERT INTO @Script VALUES ('WHERE FormatCode = ' + @QuotedFormatCode )
   INSERT INTO @Script VALUES ('AND CfgName LIKE ''%path%''')
   INSERT INTO @Script VALUES ('')

END


-----------
-- Add AscExp expSystemIDs to U_dsi_RipoutParms
-----------

IF @NewFormatCode = '' BEGIN

   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('-- Add AscExp expSystemIDs to U_dsi_RipoutParms')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02) ')
   INSERT INTO @Script VALUES ('SELECT')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('ExpFormatCode,')
   INSERT INTO @Script VALUES ('''expSystemID'',')
   INSERT INTO @Script VALUES ('ExpExportCode,')
   INSERT INTO @Script VALUES ('ExpSystemID')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('FROM dbo.AscExp')
   INSERT INTO @Script VALUES ('WHERE ExpFormatCode = ' + @QuotedFormatCode )
   INSERT INTO @Script VALUES ('')

END


-----------
-- Delete configuration data
-----------

INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('-- Delete configuration data')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = ' + @QuotedFormatCode + ')')
INSERT INTO @Script VALUES ('DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('IF OBJECT_ID(''dbo.U_dsi_Translations'')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('IF OBJECT_ID(''dbo.U_dsi_Translations_v2'') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('IF OBJECT_ID(''dbo.U_dsi_Translations_v3'') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = ' + @QuotedFormatCode)
INSERT INTO @Script VALUES ('')


    -----------
    -- Create Object List
    -----------

    -- IsExport: 0> Part of the export, e.g. driver tables
    --           1> UKG delivered objects, e.g. U_Dsi_Configuration
    --           2> Contains the FormatCode but is not dropped, e.g. permanent tables


    CREATE TABLE dbo.##SQLObjects (
    RowID    INT IDENTITY(1,1),
    ObjID    INT,
    ObjType  VARCHAR(32),
    ObjName  VARCHAR(256),
    IsExport INT
    );


    -- Get UKG Pro standard objects, e.g. AscDefF
    -- The sort forces AscDefF and AscDefH to the top

    INSERT INTO dbo.##SQLObjects
    SELECT

    ObjID    = RTRIM(id),
    ObjType  = 'U', -- AscDefF and AscDefH are views; overriding here
    ObjName  = name,
    IsExport = 1

    FROM dbo.sysobjects S
    JOIN dbo.dsi_BDM_fn_ListToTable (@DSI_TableList) ON item = name
    ORDER BY CASE
                WHEN name = 'AscDefH' THEN 1
                WHEN name = 'AscDefF' THEN 2
                ELSE 3
             END,
             name


     -- Add export-specific objects, e.g. driver tables, stored procs

     INSERT INTO dbo.##SQLObjects
     SELECT

         ObjID    = RTRIM(id)
        ,ObjType  = RTRIM(type)
        ,ObjName  = RTRIM(REPLACE(name,'U_','U_'))
        ,IsExport = CASE WHEN name LIKE '%' + @FormatCode + '%Map%' THEN 2
                         WHEN name LIKE '%' + @FormatCode + '[_]Perm[_]%' THEN 2
                         ELSE 0
                    END

     FROM dbo.sysobjects S
     WHERE name NOT LIKE '%G10_BKP_2020%' AND (
       (name LIKE '%[_]' + @FormatCode + '[_]%' AND type IN ('P','V','FN','TF','IF','U'))
        OR (name LIKE '%[_]' + @FormatCode + '' AND type IN ('P','V','FN','TF','IF','U'))
        OR (name LIKE 'dsi_vw' + @FormatCode + '[_]%'  AND type = 'V'))
     ORDER BY CASE
                 WHEN type = 'U' THEN 1
                 WHEN type = 'P' THEN 2
                 WHEN type = 'V' THEN 3
                 WHEN type IN ('FN','TF','IF') THEN 4
              END,
              name


     -- Get any procedures called in AdhPreProcessSQL

     INSERT INTO dbo.##SQLObjects
     SELECT

         ObjID    = RTRIM(id)
        ,ObjType  = RTRIM(type)
        ,ObjName  = RTRIM(REPLACE(name,'U_','U_'))
        ,IsExport = CASE WHEN name LIKE '%' + @FormatCode + '%Map%' THEN 2
                         WHEN name LIKE '%' + @FormatCode + '[_]Perm[_]%' THEN 2
                         ELSE 0
                    END
  
        FROM dbo.sysobjects S
        JOIN dbo.AscDefH WITH (NOLOCK) ON AdhFormatCode = @FormatCode AND REPLACE(CONVERT(varchar(256), AdhPreProcessSQL), 'dbo.', '') = name
        WHERE name NOT LIKE '%[_]' + @FormatCode + '[_]%'
          AND name NOT LIKE '%[_]' + @FormatCode
          AND name NOT LIKE '%G10_BKP_2020%'
          AND name NOT LIKE '%dsi_sp_Switchbox%';

    SET @ObjectCnt = (SELECT COUNT(1) FROM dbo.##SQLObjects);


-----------
-- Drop current objects
-----------

INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('-- Drop export-specific objects')
INSERT INTO @Script VALUES ('-----------')
INSERT INTO @Script VALUES ('')

SET @DelLoop = @ObjectCnt;
WHILE @DelLoop > 0 BEGIN

    SELECT
       @ObjectID   = ObjID
      ,@ObjectType = ObjType
      ,@ObjectName = ObjName
      ,@IsExport   = IsExport
    FROM dbo.##SQLObjects
    WHERE RowID = @DelLoop;

    IF @ObjectType IN ('U','V','P','FN','TF','IF') BEGIN

        IF @IsExport = 0 OR (@AllObjects = 'Y' AND @IsExport <> 1)
        BEGIN
            SELECT @SQLStmnt = 'SELECT ''IF OBJECT_ID(''''' + @ObjectName   + ''''') IS NOT NULL '
                                + 'DROP ' + CASE WHEN @ObjectType = 'U' THEN 'TABLE '
                                                 WHEN @ObjectType = 'V' THEN 'VIEW '
                                                 WHEN @ObjectType IN ('FN','TF','IF') THEN 'FUNCTION '
                                                 WHEN @ObjectType = 'P' THEN 'PROCEDURE '
                                            END
                                + '[dbo].[' + @ObjectName + '];''';

            INSERT INTO @Script (SQLStmt)
            EXEC sys.sp_executesql @SQLStmnt;

            INSERT INTO @Script (SQLStmt) VALUES ('GO');
        END;

        SET @DelLoop = @DelLoop - 1;
    END;
END;


-----------
-- Get Table Columns
-----------

-- SC.status <> 128 removes IDENTITY fields

IF OBJECT_ID('tempdb.dbo.##TableColumns') IS NOT NULL DROP TABLE ##TableColumns;

SELECT

 SC_name       = SC.name
,SO_name       = SO.name
,SC_colid      = SC.colid
,ST_name       = ST.name
,SC_isnullable = isnullable
,SC_length     = IIF(SC.length < 0, 1, SC.length)
,SO_id         = SO.id
,SO_type       = SO.xtype

INTO ##TableColumns
FROM syscolumns SC
JOIN sysobjects SO ON SC.id = SO.id AND (SO.xtype = 'U' OR SO.Name IN ('AscDefH', 'AscDefF'))
JOIN systypes ST ON SC.xtype = ST.xtype
WHERE ST.name NOT IN ('image', 'sysname')
  AND SC.status <> 128
  AND EXISTS (SELECT 1 FROM dbo.##SQLObjects a WHERE SO.id = a.ObjID);


-----------
-- Delete AuditKey for AscDefF and AscDefH
-----------

DELETE FROM ##TableColumns
 WHERE SO_name IN ('AscDefH', 'AscDefF')
   AND SC_name = 'AuditKey'




    -----------
    -- Process Object Loop
    -----------

    WHILE @MainLoop <= @ObjectCnt BEGIN

        SELECT
             @ObjectID   = RTRIM(ObjID)
            ,@ObjectType = ObjType
            ,@ObjectName = ObjName
            ,@IsExport   = IsExport

        FROM dbo.##SQLObjects
        WHERE RowID = @MainLoop;

        DELETE FROM @TblSQL;


        -----------
        -- Create Tables And Inserts
        -----------

        IF @ObjectType = 'U' BEGIN

            -----------
            -- Create Export-Specific Tables
            -----------

            IF (@AllObjects = 'Y' AND @IsExport <> 1) OR @ObjectName LIKE 'U[_]%[_]File' BEGIN

                -----------
                -- Create Tables
                -----------

                INSERT INTO @TblSQL(s) VALUES ('IF OBJECT_ID(''' + @ObjectName   + ''') IS NULL');
                INSERT INTO @TblSQL(s) VALUES ('CREATE TABLE [dbo].[' + @ObjectName + '] (');

                -- Populate the column list

                INSERT INTO @TblSQL(s)
                SELECT
                    '    [' + COLUMN_NAME + '] '
                    + DATA_TYPE
                    + COALESCE('(' + CASE WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN 'max'
                                          ELSE CAST(CHARACTER_MAXIMUM_LENGTH AS varchar)
                                     END
                                   + ')', '')
                    + CASE WHEN EXISTS (SELECT id FROM sys.syscolumns
                                        WHERE object_name(id) = @ObjectName
                                          AND name = COLUMN_NAME
                                          AND COLUMNPROPERTY(id, name, 'ISIDENTITY') = 1)
                                THEN ' IDENTITY('
                                      + CAST(IDENT_SEED(@ObjectName) AS varchar) + ','
                                      + CAST(IDENT_INCR(@ObjectName) AS varchar) + ')'
                           ELSE ''
                      END
                    + CASE WHEN IS_NULLABLE = 'NO' THEN ' NOT'
                           ELSE ''
                      END + ' NULL'
                    + COALESCE(' DEFAULT ' + COLUMN_DEFAULT, '')
                    + ','
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_NAME = @ObjectName
                ORDER BY ORDINAL_POSITION;


                -----------
                -- Populate Primary Key If It Exists; Remove Trailing Comma
                -----------

                SET @PKNAME = NULL;

                SELECT @PKNAME = CONSTRAINT_NAME
                FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                WHERE TABLE_NAME = @ObjectName
                  AND CONSTRAINT_TYPE = 'PRIMARY KEY';

                IF @PKNAME IS NOT NULL BEGIN
                    INSERT INTO @TblSQL(s)
                        VALUES ('  PRIMARY KEY (');
                    INSERT INTO @TblSQL(s)
                        SELECT '   [' + COLUMN_NAME + '],'
                        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                        WHERE CONSTRAINT_NAME = @PKNAME
                        ORDER BY ORDINAL_POSITION;

                    UPDATE @TblSQL
                    SET s = LEFT(s,len(s)-1)
                    WHERE id = @@IDENTITY; -- Remove trailing comma

                    INSERT INTO @TblSQL(s)
                        VALUES ('  )');
                END
                ELSE
                BEGIN
                    UPDATE @TblSQL
                    SET s = LEFT(s,len(s)-1)
                    WHERE id = @@IDENTITY; -- Remove trailing comma
                END;

                -----------
                -- Close Table Create
                -----------
                INSERT INTO @TblSQL(s) VALUES( ');' );

                INSERT INTO @Script VALUES ('')
                INSERT INTO @Script VALUES ('-----------')
                INSERT INTO @Script VALUES ('-- Create table ' + @ObjectName)
                INSERT INTO @Script VALUES ('-----------')
                INSERT INTO @Script VALUES ('')

                INSERT INTO @Script (SQLStmt)
                    SELECT s
                    FROM @TblSQL
                    ORDER BY id;
            END; -- End Export-Specific Table Creates


            -----------
            -- Create Insert/Values Statement For UKG Tables
            -----------

            IF @IsExport = 1 OR (@AllObjects = 'Y' AND @IsExport = 2) BEGIN

                -----------
                -- Gather Web path variables up front for Web ripouts to set in AscExp
                -----------

                IF @ObjectID = (SELECT DISTINCT SO_id FROM ##TableColumns WHERE SO_name = 'AscExp') AND @IsWeb = 'Y' BEGIN

                    --\\[@COUNTRY].saas\[@SERVER]\[@ENVIRONMENT]\Downloads\V10\Exports\[@COCODE]\EmployeeHistoryExport

                    INSERT INTO @Script VALUES ('')
                    INSERT INTO @Script VALUES ('-----------')
                    INSERT INTO @Script VALUES ('-- Build web filename')
                    INSERT INTO @Script VALUES ('-----------')
                    INSERT INTO @Script VALUES ('');

                    WITH CTE_AscExp AS (
                        SELECT DISTINCT 1 E FROM dbo.AscExp WITH (NOLOCK)
                        WHERE expFormatCode = @FormatCode
                    )
                    INSERT INTO @Script (SQLStmt)

                        -- Declare and set the country

                        SELECT '/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 1) = ''T'' THEN ''ca'' ELSE ''us'' END);'
                        FROM CTE_AscExp
                        UNION

                        -- Declare and set the server portion of the path

                        SELECT '/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 3) IN (''WP1'',''WP2'',''WP3'',''WP4'',''WP5'') THEN ''WP''' +
                                                                               ' WHEN LEFT(@@SERVERNAME, 2) IN (''NW'',''EW'',''WP'') THEN LEFT(@@SERVERNAME, 3)' +
                                                                               ' ELSE LEFT(@@SERVERNAME, 2) END);'
                        FROM CTE_AscExp
                        UNION

                        -- Update UDE and DED Test servers to include additional servername

                        SELECT '/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME, 2) IN (''NZ'',''EZ'') THEN @SERVER + ''\'' + LEFT(@@SERVERNAME, 3) ELSE @SERVER END;'
                        FROM CTE_AscExp
                        UNION

                        -- Declare and set the AR# (contract number), from CompMast

                        SELECT '/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);'
                        FROM CTE_AscExp
                        UNION

                        -- Declare and set the server. This will be the starting portion of the server, up to the first number, followed by the number after UP

                        SELECT '/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = ''D'' THEN @UDARNUM' +
                                                                                ' WHEN SUBSTRING(@@SERVERNAME,4,1) = ''D'' THEN LEFT(@@SERVERNAME,3) + ''Z''' + -- LEFT(@@SERVERNAME,4)' +
                                                                                ' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX(''%[0-9]%'',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX(''%UP[0-9]%'',@@SERVERNAME)+2,1))' +
                                                                                ' END);'
                        FROM CTE_AscExp
                        UNION

                        -- Fix the server for EW21 and EW22

                        SELECT '/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = ''EW21'' THEN ''WP6''' +
                                                             ' WHEN @ENVIRONMENT = ''EW22'' THEN ''WP7''' +
                                                             ' ELSE @ENVIRONMENT END;'
                        FROM CTE_AscExp
                        UNION

                        -- Declare and set the company code

                        SELECT '/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);'
                        FROM CTE_AscExp
                        UNION

                        -- Declare and set the filename

                        SELECT '/*08*/ DECLARE @FileName varchar(1000) = ''' + @FormatCode + '_' + CONVERT(char(8), GETDATE(), 112) + '.txt'';'
                        FROM CTE_AscExp
                        UNION

                        -- Declare and set the export path

                        SELECT '/*09*/ DECLARE @FilePath varchar(1000) = ''\\'' + @COUNTRY + ''.saas\'' + @SERVER + ''\'' + @ENVIRONMENT + ''\Downloads\V10\Exports\'' + @COCODE + ''\EmployeeHistoryExport\'';'
                        FROM CTE_AscExp
                END;


                -----------
                -- Build inserts for dsi tables
                -----------

                -- Get Column names

                SET @ColumnNames = (SELECT ',' + SC_name
                                      FROM ##TableColumns
                                     WHERE SO_id = @ObjectID
                                    ORDER BY SC_colid
                                    FOR XML PATH(''));

                SET @ColumnNames = SUBSTRING(@ColumnNames, 2, LEN(@ColumnNames)); -- Remove leading comma

                -- Get Column values
                -- If this is a cloned ripout, blank the COID list and selectors

                SET @ColumnValues = (SELECT '+'',''+' +
                                            CASE
                                               WHEN SO_name = 'AscExp' AND SC_name = 'ExpCOIDList'      AND @NewFormatCode <> '' THEN dbo.Custom_Quotename('NULL', '''')
                                               WHEN SO_name = 'AscExp' AND SC_name = 'ExpSelectByField' AND @NewFormatCode <> '' THEN dbo.Custom_Quotename('NULL', '''')
                                               WHEN SO_name = 'AscExp' AND SC_name = 'ExpSelectByList'  AND @NewFormatCode <> '' THEN dbo.Custom_Quotename('NULL', '''')
                                               WHEN SC_name = 'expAscFileName' AND SO_name = 'AscExp' THEN
                                                  CASE
                                                     WHEN @IsWeb = 'Y' THEN '''RTRIM(@FilePath) + LTRIM(RTRIM(@FileName))'''
                                                     ELSE 'ISNULL(dbo.Custom_Quotename(RTRIM(CONVERT(VARCHAR(8000),' + SC_name + ')),''''''''),''NULL'')'
                                                  END
                                               WHEN SC_name IN ('AdhModifyStamp','expSystemID','impSystemID') AND SO_name IN ('AscDefH','AscExp','AscImp') THEN '''dbo.fn_GetTimedKey()'''
                                               ELSE 'ISNULL(dbo.Custom_Quotename(RTRIM(CONVERT(VARCHAR(8000),' + SC_name + ')),''''''''),''NULL'')'
                                            END
                                     FROM ##TableColumns
                                     WHERE SO_id = @ObjectID
                                     ORDER BY SC_colid
                                     FOR XML PATH(''));

                SET @ColumnValues = SUBSTRING(@ColumnValues, 6, LEN(@ColumnValues)); -- Remove leading +','+


                -- Get Where values

                SET @WhereConds = CASE WHEN @IsExport = 2 THEN NULL
                                       WHEN @ObjectName LIKE 'U_dsi%' THEN 'FormatCode =    ' + @QuotedFormatCode
                                       WHEN @ObjectName = 'AscExp'    THEN 'expFormatCode = ' + @QuotedFormatCode
                                       WHEN @ObjectName = 'AscImp'    THEN 'impFormatCode = ' + @QuotedFormatCode
                                       WHEN @ObjectName = 'AscDefH'   THEN 'AdhFormatCode = ' + @QuotedFormatCode
                                       WHEN @ObjectName = 'AscDefF'   THEN 'AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = ' + @QuotedFormatCode+ ')'
                                       ELSE NULL
                                  END +
                                  CASE WHEN @ObjectName = 'U_dsi_SQLClauses' THEN ' ORDER BY CASE WHEN LEFT(RecordSet,1) = ''H'' THEN 1 WHEN LEFT(RecordSet,1) = ''D'' THEN 2 ELSE 3 END, SUBSTRING(RecordSet,2,2)'
                                       WHEN @ObjectName = 'AscDefF' THEN ' ORDER BY CASE WHEN AdfRecType = ''H'' THEN 1 WHEN AdfRecType = ''D'' THEN 2 ELSE 3 END, CAST(AdfSetNumber AS int), CAST(AdfFieldNumber AS int)'
                                       WHEN @ObjectName = 'AscExp' THEN ' ORDER BY expExportCode'
                                       ELSE ''
                                  END + ';';

                -- Generate SQL statement

                SET @SQLStmnt = 'SELECT ''INSERT INTO [dbo].[' + @ObjectName + '] '
                                 + '(' + @ColumnNames + ') VALUES '
                                 + '('' + ' + @ColumnValues + ' + '');'''
                                 + ' FROM '
                                 + @FromDB + '.dbo.' + @ObjectName
                                 + COALESCE(' WHERE ' + @WhereConds, SPACE(0));

                INSERT INTO @Script VALUES ('')
                INSERT INTO @Script VALUES ('-----------')
                INSERT INTO @Script VALUES ('-- ' + @ObjectName + ' inserts')
                INSERT INTO @Script VALUES ('-----------')
                INSERT INTO @Script VALUES ('')



                -- Add to ripout

                INSERT INTO @Script (SQLStmt)
                    EXEC sys.sp_executesql @SQLStmnt;



            END; -- End UKG Table Inserts
        END; -- End Table Creates/Inserts


        -----------
        -- Get Non-Table Objects, i.e. stored procs and functions
        -----------

        IF @ObjectType != 'U' BEGIN

            -----------
            -- Declare and initialize variables
            -----------
            DECLARE @Definition nvarchar(max) = '';
            DECLARE @CurLine nvarchar(max) = '';
            DECLARE @Pos bigint;

            DECLARE @tvObject table
            (
                 [LineNum] int IDENTITY(1, 1) NOT NULL,
                 [CodeLine] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
            );


            -----------
            -- Get object definition
            -- Replace CRLF with CHAR(143) so we can set newlines later
            -- Replace TABs with SPACE(4) since Results-to-Grid doesn't preserve tabs
            -----------

            SELECT @Definition = REPLACE(REPLACE(definition, @CRLF, CHAR(143)), @Tab, SPACE(4))
            FROM sys.sql_modules
            WHERE object_id = @ObjectID;


            -----------
            -- Move through definition and replace CHAR(143) with new line
            -----------

            -- We use a TV instead of the target table so we can manipulate it first

            WHILE 1 = 1 BEGIN

                SET @Pos = CHARINDEX(CHAR(143), @Definition);

                IF @Pos > 0
                BEGIN
                    SET @CurLine = SUBSTRING(@Definition, 1, @Pos - 1);

                    INSERT INTO @tvObject
                        VALUES (@CurLine);

                    SET @Definition = SUBSTRING(@Definition, @Pos + 1, 1000000);
                END
                ELSE
                BEGIN
                    IF @Definition <> ''
                    BEGIN
                        SET @CurLine = @Definition;
                        INSERT INTO @tvObject
                            VALUES (@CurLine);
                    END;
                END;

                IF @Pos = 0
                    BREAK;
            END; -- End copy definition


            -----------
            -- Delete blank lines at beginning
            -----------

            WHILE 1 = 1 BEGIN
                DELETE FROM @tvObject
                WHERE LineNum = (SELECT MIN(LineNum) FROM @tvObject)
                  AND LTRIM(RTRIM(COALESCE(CodeLine, ''))) = '';

                IF @@ROWCOUNT = 0 BREAK;
            END;


            -----------
            -- Delete blank lines at end
            -----------
            WHILE 1 = 1 BEGIN
                DELETE FROM @tvObject
                WHERE LineNum = (SELECT MAX (LineNum) FROM @tvObject)
                  AND LTRIM(RTRIM(COALESCE(CodeLine, ''))) = '';

                IF @@ROWCOUNT = 0 BREAK;
            END;

            -----------
            -- Insert Into Main Table
            -----------

            INSERT INTO @Script (SQLStmt)
                SELECT 'GO';
            INSERT INTO @Script (SQLStmt)
                SELECT CodeLine
                FROM @tvObject
                ORDER BY LineNum;

            DELETE @tvObject;
        END; -- End Non-Table Object Retrieval

        SET @MainLoop = @MainLoop + 1; -- Increase Main Loop For Next

    END; -- End Main Loop To Retrieve Next Object



-----------
-- Start updates
-----------

INSERT INTO @Script VALUES ('')
INSERT INTO @Script VALUES ('GO')
INSERT INTO @Script VALUES ('')


-----------
-- Insert a record into the CustomTemplates table so it's visible on the Web
-----------

IF @IsWeb = 'Y' BEGIN

   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('-- This is a web export; insert a record into the CustomTemplates table to make it visible')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('')   INSERT INTO @Script VALUES ('INSERT INTO dbo.CustomTemplates (Engine, EngineCode)')
   INSERT INTO @Script VALUES ('SELECT Engine = AdhEngine, EngineCode = AdhFormatCode')
   INSERT INTO @Script VALUES ('  FROM dbo.AscDefH WITH (NOLOCK)')
   INSERT INTO @Script VALUES (' WHERE AdhFormatCode = ' + @QuotedFormatCode + ' AND AdhEngine = ''EMPEXPORT''')
   INSERT INTO @Script VALUES ('   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);')
   INSERT INTO @Script VALUES ('')

END


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

IF @NewFormatCode = '' BEGIN


   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('-- Restore target paths from U_dsi_RipoutParms')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('UPDATE dbo.U_dsi_Configuration')
   INSERT INTO @Script VALUES ('   SET CfgValue = rpoParmValue02')
   INSERT INTO @Script VALUES ('  FROM dbo.U_dsi_Configuration')
   INSERT INTO @Script VALUES ('  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName')
   INSERT INTO @Script VALUES (' WHERE rpoFormatCode = ' + @QuotedFormatCode)
   INSERT INTO @Script VALUES ('   AND rpoParmType = ''Path''')
   INSERT INTO @Script VALUES ('')

END


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

IF @NewFormatCode = '' BEGIN

   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('-- Restore expSystemIDs from U_dsi_RipoutParms')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('UPDATE dbo.AscExp')
   INSERT INTO @Script VALUES ('   SET expSystemID = rpoParmValue02')
   INSERT INTO @Script VALUES ('  FROM dbo.AscExp')
   INSERT INTO @Script VALUES ('  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode')
   INSERT INTO @Script VALUES (' WHERE rpoFormatCode = ' + @QuotedFormatCode)
   INSERT INTO @Script VALUES ('   AND rpoParmType = ''expSystemID''')
   INSERT INTO @Script VALUES ('')

END


-----------
-- Set paths to NULL for web exports
-----------

IF @IsWeb = 'Y' BEGIN

   SET @Temp = 'EXEC dbo.dsi_sp_UpdateConfig ' + @QuotedFormatCode + ', ''ExportPath'', ''V'', NULL'

   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('-- This is a web export; set paths to NULL')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES (@Temp)

    SET @Temp = 'EXEC dbo.dsi_sp_UpdateConfig ' + @QuotedFormatCode + ', ''TestPath'', ''V'', NULL'

   INSERT INTO @Script VALUES (@Temp)
   INSERT INTO @Script VALUES ('')

END


-----------
-- Set UseFileName = Y for web exports
-----------

-- EXEC dbo.dsi_sp_UpdateConfig @FormatCode, 'FileNumber', 'V', @FileNum

IF @IsWeb = 'Y' BEGIN

   SET @Temp = 'EXEC dbo.dsi_sp_UpdateConfig ' + @QuotedFormatCode + ', ''UseFileName'', ''V'', ''Y'''

   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('-- This is a web export; set UseFileName = Y')
   INSERT INTO @Script VALUES ('-----------')
   INSERT INTO @Script VALUES ('')
   INSERT INTO @Script VALUES (@Temp)
   INSERT INTO @Script VALUES ('')

END




-----------
-- Create Flower Box
-----------

IF EXISTS (SELECT 1 FROM @Script) BEGIN

    DECLARE @ScriptFinal AS TABLE
    (SQLRecId int IDENTITY, SQLStmt varchar(max));

    SELECT @Project = LTRIM(RTRIM(ISNULL(AdhFormatName, ''))) FROM dbo.AscDefH WHERE AdhFormatCode = @FormatCode


    -- Get latest service request number

    DECLARE @ServiceRequests AS TABLE
    (SQLStmt varchar(max));

    INSERT INTO @ServiceRequests
    SELECT

    SUBSTRING(SQLStmt, PATINDEX('%SR-20[1-2][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]%', SQLStmt), 16)

    FROM @Script WHERE PATINDEX('%SR-20[1-2][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]%', SQLStmt) > 0

    SELECT @SRNumber = MAX(SQLStmt) FROM @ServiceRequests
    IF ISNULL(@SRNumber, '') = '' SET @SRNumber = '[Unable to determine SR Number]'


    -- Get company info

    SELECT

    @COID     = CmmCOID,
    @ARNumber = LOWER(CmmContractNo)
    FROM dbo.CompMast

    DECLARE @ExportType VARCHAR(16)

    SELECT @ExportType = IIF(@IsWeb = 'Y', 'Web', 'Back Office')

    SET @FormatCode = UPPER(@FormatCode)
    SET @SRNumber   = UPPER(@SRNumber)
    SET @ARNumber   = UPPER(@ARNumber)

    INSERT INTO @ScriptFinal VALUES ('/**********************************************************************************')
    INSERT INTO @ScriptFinal VALUES ('')

    IF @NewFormatCode <> '' BEGIN

        INSERT INTO @ScriptFinal VALUES ('')
        INSERT INTO @ScriptFinal VALUES ('>>>>>> NOTE: this ripout is cloned from ' + @FormatCode)
        INSERT INTO @ScriptFinal VALUES ('')
        INSERT INTO @ScriptFinal VALUES ('')

    END


    INSERT INTO @ScriptFinal VALUES (RTRIM(@FormatCode) + ': ' + ISNULL(@Project, ''))
    INSERT INTO @ScriptFinal VALUES ('')
    INSERT INTO @ScriptFinal VALUES ('FormatCode:     ' + @FormatCode)
    INSERT INTO @ScriptFinal VALUES ('Project:        ' + @Project)
    INSERT INTO @ScriptFinal VALUES ('Client ID:      ' + @ARNumber)
    INSERT INTO @ScriptFinal VALUES ('Date/time:      ' + CONVERT(VARCHAR, GETDATE(), 121))
    INSERT INTO @ScriptFinal VALUES ('Ripout version: ' + '7.4')
    INSERT INTO @ScriptFinal VALUES ('Export Type:    ' + @ExportType)
    INSERT INTO @ScriptFinal VALUES ('Status:         ' + IIF(dbo.dsi_fnVariable(@FormatCode, 'Testing') = 'Y', 'Testing', 'Production'))
    INSERT INTO @ScriptFinal VALUES ('Environment:    ' + CASE
                                                            WHEN SUBSTRING(@@SERVERNAME, 2, 1) = 'Z' THEN LEFT(@@SERVERNAME, 3) + SUBSTRING(@@SERVERNAME, 7, 1)
                                                            ELSE LEFT(@@SERVERNAME, 2) + SUBSTRING(@@SERVERNAME, 6, 1)
                                                         END)
    INSERT INTO @ScriptFinal VALUES ('Server:         ' + @@SERVERNAME)
    INSERT INTO @ScriptFinal VALUES ('Database:       ' + @FromDB)


    IF @ExportType = 'Web' BEGIN
       INSERT INTO @ScriptFinal VALUES ('Web Filename:   ' + @ARNumber + '_' + @COID + '_EEHISTORY_' + @FormatCode + '_ExportCode_YYYYMMDD_HHMMSS.txt' )
    END


    -- Paths

    INSERT INTO @ScriptFinal
    SELECT

    RTRIM(CfgName) + ':' + REPLICATE(' ', (14 - LEN(RTRIM(CfgName)))) + ISNULL(CfgValue, '')

    FROM dbo.U_Dsi_Configuration
    WHERE FormatCode = @FormatCode
      AND CfgName LIKE '%Path'
      AND CfgName <> 'UDESPath'
    ORDER BY CfgName


     -- MultFile

    IF dbo.dsi_fnVariable(@FormatCode, 'MultFile') = 'Y' BEGIN

       INSERT INTO @ScriptFinal VALUES ('')
       INSERT INTO @ScriptFinal VALUES ('NOTE:          MultFile is set to Y, meaning Switchbox doesn''t directly write the file.')
       INSERT INTO @ScriptFinal VALUES ('               The file(s) are probably created by an AfterCollect.')
       INSERT INTO @ScriptFinal VALUES ('')

    END


    -- End flower box

    INSERT INTO @ScriptFinal VALUES ('')
    INSERT INTO @ScriptFinal VALUES ('**********************************************************************************/')
    INSERT INTO @ScriptFinal VALUES ('')

    INSERT INTO @ScriptFinal
    SELECT SQLStmt
    FROM @Script
    ORDER BY SQLRecId;

END


-----------
-- Generate warning if @IsWeb doesn't match project
-----------

SET @Cnt = 0

SELECT @Cnt = COUNT(1) FROM dbo.CustomTemplates
 WHERE Engine = 'EmpExport'
   AND EngineCode = @FormatCode

IF @@SERVERNAME <> 'EZ2SUP4DB01' BEGIN

    IF ISNULL(@Cnt, 0) > 0 AND ISNULL(@IsWeb, '') = 'N' BEGIN
       SELECT 'Warning: IsWeb is set to N but this appears to be a web-based project'
    END

    IF ISNULL(@Cnt, 0) = 0 AND ISNULL(@IsWeb, '') = 'Y' BEGIN
        SELECT 'Warning: IsWeb is set to Y but this appears to be a Back Office project'
    END

END


-----------
-- New FormatCode; change FormatCode and generate new SystemID in AscDefF/AscDefH
-----------

-- Allows the TC to clone a project on the same database without needing to update the AscDefF/AscDefH SystemIDs

IF @NewFormatCode <> '' BEGIN

   DECLARE @CurrentSystemID CHAR(12)
   DECLARE @NewSystemID     CHAR(12)

   SELECT @CurrentSystemID = AdhSystemID
     FROM dbo.AscDefH
    WHERE AdhFormatCode = @FormatCode

   IF ISNULL(@CurrentSystemID, '') <> '' BEGIN

      SET @NewSystemID = dbo.fn_GetTimedKey();

      UPDATE @ScriptFinal
         SET SQLStmt = REPLACE(SQLStmt, @CurrentSystemID, @NewSystemID)
       WHERE SQLStmt LIKE '%' + @CurrentSystemID + '%'

   END

   UPDATE @ScriptFinal
      SET SQLStmt = REPLACE(SQLStmt, @FormatCode, @NewFormatCode)
     WHERE SQLStmt NOT LIKE '>>>>>> NOTE: this ripout is cloned from%'

END


-----------
-- Insert End ripout comment
-----------

INSERT INTO @ScriptFinal VALUES ('')
INSERT INTO @ScriptFinal VALUES ('-- End ripout')


-----------
-- Output To Screen & File
-----------

IF EXISTS (SELECT 1 FROM @Script) BEGIN

    IF OBJECT_ID('tempdb.dbo.##Export') IS NOT NULL DROP TABLE dbo.##Export;

    CREATE TABLE dbo.##Export
    (
         SQLRecId int IDENTITY
        ,SQLStmt nvarchar(max)
    );

    INSERT INTO dbo.##Export
    OUTPUT INSERTED.SQLStmt -- this outputs to the screen
    SELECT SQLStmt
    FROM @ScriptFinal
    ORDER BY SQLRecId;


    UPDATE dbo.##Export
    SET SQLStmt = '--%!%'
    WHERE SQLStmt = ' ';

    DELETE FROM dbo.##Export
    WHERE SQLRecId IN (SELECT SQLRecId
                       FROM dbo.##Export a
                       WHERE SQLStmt = '--%!%'
                         AND EXISTS (SELECT 1
                                     FROM dbo.##Export b
                                     WHERE b.SQLStmt = '--%!%'
                                       AND a.SQLRecId = b.SQLRecId - 1));

    UPDATE dbo.##Export
    SET SQLStmt = NULL
    WHERE SQLStmt = '--%!%';

    -----------
    -- Bcp File If @FilePathName Is Not Null
    -----------

    IF @FilePathName IS NOT NULL BEGIN

        DECLARE @BCPSTMNT varchar(8000);

        SELECT @BCPSTMNT = 'bcp "SELECT rtrim(SQLStmt) from ' + DB_NAME() + '.dbo.##Export ORDER BY SQLRecId" QUERYOUT "' + @FilePathName + '" -S'
                            + @@SERVERNAME + ' -T -c -t';
        EXEC master.dbo.xp_cmdshell @BCPSTMNT, NO_OUTPUT;
    END;
END; -- End Output To Screen And File



-----------
-- Drop temp tables
-----------

IF OBJECT_ID('tempdb.dbo.##SQLObjects')   IS NOT NULL DROP TABLE dbo.##SQLObjects;
IF OBJECT_ID('tempdb.dbo.##TableColumns') IS NOT NULL DROP TABLE dbo.##TableColumns;
IF OBJECT_ID('tempdb.dbo.##Export')       IS NOT NULL DROP TABLE dbo.##Export;


EndProgram:

END;
