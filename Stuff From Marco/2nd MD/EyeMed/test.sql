CREATE PROCEDURE [dbo].[dsi_BIM_sp_PopulateImportTable]  
    @FormatCode VARCHAR(10)  
AS  
SET NOCOUNT ON;  
/**********************************************************************************  
  
Created By: Tanya Leonce  
Create Date: 02/01/2017  
  
Purpose: Creates and populated an Import Table by Format Code  
  
NOTE TO SUPPORT: This database object is one of a standard set of DSI functions. Please do not make any changes  
to this database object without going through the Data Services team. Any changes made to this database object  
will be wiped out if/when the standard DSI code is reinstalled on this database.  
  
Revision History  
----------------  
Update By        Date            Req Num            Descr  
XXXXXXXXXXX      XX/XX/XXXX      SR-XXXX-XXXXXX     XXXXXXXXX  
    
**********************************************************************************/  
BEGIN  
  
    --=============================================  
    -- Start Logging Process Steps  
    --=============================================  
    DECLARE @StepID DECIMAL(5,2) = 0.00;  
    INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
    VALUES (@FormatCode,NULL,@StepID,'STARTBIM','Begin BIM Code - Clear BIM Processes Table');  
  
    --=============================================  
    -- Clear BIM Processes Table By FormatCode  
    --=============================================  
    DELETE FROM dbo.U_dsi_BIM_Processes WHERE bimFormatCode = @FormatCode;  
  
    --=============================================  
    -- Declare Variables  
    --=============================================  
    DECLARE @xFormatCode        VARCHAR(10);  
    DECLARE @xExportCode        VARCHAR(10);  
    DECLARE @xFilePath          VARCHAR(500);  
    DECLARE @xFileName          VARCHAR(500);  
    DECLARE @xFileExists        BIT;  
    DECLARE @xFileFormat        VARCHAR(25);  
    DECLARE @xCMD               VARCHAR(8000);  
    DECLARE @xFieldCount        INT;  
    DECLARE @xKeyEEID           VARCHAR(50);  
    DECLARE @xKeyCOID           VARCHAR(50);  
    DECLARE @xMultipleFiles     CHAR(1);  
    DECLARE @xArchiveFiles      CHAR(1);  
    DECLARE @xCopyFiles         CHAR(1);  
    DECLARE @AddToPreviousRun   CHAR(1);  
    DECLARE @TestingFlag        VARCHAR(1);  
  
    SET @xFormatCode            = LTRIM(RTRIM(@FormatCode));  
    SET @xCMD                   = '';  
    SET @xExportCode            = (SELECT ExportCode FROM dbo.U_dsi_Parameters WHERE FormatCode = @xFormatCode);  
    SET @xFilePath              = (SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'FilePath');  
    SET @xFileName              = (SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'FileName');  
    SET @xFileFormat            = (SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'FileFormat');  
    SET @xFieldCount            = (SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'FieldCount');  
    SET @xKeyEEID               = (SELECT TOP 1 ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'KeyEEID');  
    SET @xKeyCOID               = (SELECT TOP 1 ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'KeyCOID');  
    SET @xMultipleFiles         = COALESCE((SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'MultipleFiles'),'N');  
    SET @xArchiveFiles          = COALESCE((SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'ArchiveFiles'),'N');  
    SET @xCopyFiles             = COALESCE((SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'CopyFiles'),'N');  
    SET @AddToPreviousRun       = COALESCE((SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'AddToPreviousRun'),'N');  
    SET @TestingFlag            = dbo.dsi_fnVariable(@FormatCode,'Testing');  
  
    -- Clean File Name (Remove Path) and File Path  
    SET @xFileName = dbo.dsi_BIM_fn_CleanFileName (@xFileName);  
    SET @xFilePath = dbo.dsi_BIM_fn_FormatFilePath(@xFilePath);  
  
    -- Track Process Step - Declare and Set Initial Variables  
    SET @StepID += 1;  
    INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
    VALUES (@xFormatCode,@xExportCode,@StepID,'DECLAREVARIABLES','Declare and Set Initial Variables');  
  
    --------------------------  
    -- Print input variables  
    --------------------------  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT '*** dsi_BIM_sp_PopulateImportTable ***';  
        PRINT '';  
  
        PRINT '@xFormatCode: ' + ISNULL(@xFormatCode,'');  
        PRINT '@xFilePath: ' + ISNULL(@xFilePath,'');  
        PRINT '@xFileName: ' + ISNULL(@xFileName,'');  
        PRINT '@xFileFormat: ' + ISNULL(@xFileFormat,'');  
    END;  
  
    DECLARE @srcPath VARCHAR(1000);  
    SET @srcPath = ISNULL(RTRIM(@xFilePath),'') + ISNULL(LTRIM(@xFileName),'');  
  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '@srcPath: ' + ISNULL(@srcPath,'');  
    END;  
  
    --================================================================================  
    -- Check if Required Fields are Populated  
    --================================================================================  
    IF ((NULLIF(@xFilePath,'') IS NULL)  
        OR (NULLIF(@xFileName,'') IS NULL AND @xMultipleFiles = 'N')  
        OR (NULLIF(@xFileFormat,'') IS NULL)  
        OR (NULLIF(@xFieldCount,'') IS NULL)  
    )  
    BEGIN  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT 'BIM Parameter '''  
                    + CASE WHEN NULLIF(@xFilePath,'') IS NULL THEN 'FilePath'  
                           WHEN NULLIF(@xFileName,'') IS NULL  AND @xMultipleFiles = 'N' THEN 'FileName'  
                           WHEN NULLIF(@xFileFormat,'') IS NULL THEN 'FileFormat'  
                        WHEN NULLIF(@xFieldCount,'') IS NULL THEN 'FieldCount'  
                    END  
                    + ''' is Blank.  This is a Required Field.'  
            END;  
        RETURN;  
    END  
  
    --================================================================================  
    -- Create Import Table  
    --================================================================================  
    IF (@AddToPreviousRun <> 'Y')  
    BEGIN TRY  
        -- Drop _Import Table  
        SET @xCMD = '';  
        SET @xCMD = 'IF OBJECT_ID(''U_' + @xFormatCode + '_Import'',''U'') IS NOT NULL DROP TABLE dbo.U_' + @xFormatCode + '_Import; '  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Create _Import Table  
        SET @xCMD = '';  
        SET @xCMD = 'CREATE TABLE dbo.U_' + @xFormatCode + '_Import (EEID CHAR(12) NULL, COID CHAR(5) NULL, RunID VARCHAR(50) NULL, Error VARCHAR(250) NULL, PayPeriodStartDate DATETIME NULL, PayPeriodEndDate DATETIME NULL, PriorPayPeriodStartDate DATETIME
 NULL, PriorPayPeriodEndDate DATETIME NULL, NextPayPeriodStartDate DATETIME NULL, NextPayPeriodEndDate DATETIME NULL, CompanyCode VARCHAR(100) NULL, EmployeeNo VARCHAR(10) NULL, EmployeeName VARCHAR(250) NULL ';  
  
        -- Loop Through Field Count to Append Fields to CREATE TABLE Statement  
        DECLARE @rCount INT;  
        SET @rCount = 1;  
  
        WHILE (@rCount <= @xFieldCount)  
        BEGIN  
  
            SET @xCMD = @xCMD + ',Field' + CONVERT(VARCHAR(5),@rCount) + ' VARCHAR(MAX)'  
            SET @rCount += 1;  
  
        END  
          
        --Adding 5 UDF fields   
        SET @xCMD = @xCMD + ',UDField1 VARCHAR(250),UDField2 VARCHAR(250),UDField3 VARCHAR(250),UDField4 VARCHAR(250),UDField5 VARCHAR(250)'  
          
        SET @xCMD = @xCMD + ');'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
    END TRY  
    BEGIN CATCH  
        -- Drop _Import Table  
        SET @xCMD = '';  
        SET @xCMD = 'IF OBJECT_ID(''U_' + @xFormatCode + '_Import'',''U'') IS NOT NULL DROP TABLE dbo.U_' + @xFormatCode + '_Import; '  
        EXEC (@xCMD);  
  
        -- Create _Import Table  
        SET @xCMD = '';  
        SET @xCMD = 'CREATE TABLE dbo.U_' + @xFormatCode + '_Import (EEID CHAR(12) NULL, COID CHAR(5) NULL, RunID VARCHAR(50) NULL, Error VARCHAR(250) NULL, PayPeriodStartDate DATETIME NULL, PayPeriodEndDate DATETIME NULL, PriorPayPeriodStartDate DATETIME
 NULL, PriorPayPeriodEndDate DATETIME NULL, NextPayPeriodStartDate DATETIME NULL, NextPayPeriodEndDate DATETIME NULL, CompanyCode VARCHAR(100) NULL, EmployeeNo VARCHAR(10) NULL, EmployeeName VARCHAR(250) NULL )';  
        EXEC (@xCMD);  
  
        -- Report SQL Error in Error Report File  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Creating _Import Table: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
    -- Track Process Step - Create Import Table  
    SET @StepID += 1;  
    INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
    VALUES (@xFormatCode,@xExportCode,@StepID,'CREATEIMPORTTABLE','Create Import Table');  
  
    --================================================================================  
    -- Load All FileNames from Specified 'ImportPath'  
    --================================================================================  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT '*** Load All Files From Specified Import Path ***';  
        PRINT '';  
    END;  
    BEGIN TRY  
  
        -----------------------------------------  
        -- Gather All Files in @ImportPath Folder  
        -----------------------------------------  
        DECLARE @FileCmd VARCHAR(1000);  
        SET @FileCmd = '';  
  
        -- Create File List  
        IF OBJECT_ID('U_dsi_BIM_ImportFileList') IS NOT NULL  
            DROP TABLE dbo.U_dsi_BIM_ImportFileList;  
        CREATE TABLE dbo.U_dsi_BIM_ImportFileList (  
            filFormatCode VARCHAR(10)  
            ,filID INT IDENTITY(1,1)  
            ,filFileName VARCHAR(200)  
            ,filImported BIT DEFAULT(0)  
            ,filArchived BIT DEFAULT(0)  
            ,filCopied BIT DEFAULT(0)  
            ,filDateTimeStamp DATETIME DEFAULT GETDATE()  
        );  
  
        -- Set DIR Command to Find All Files (including Subfolders)  
        SET @FileCmd = 'DIR /B /A-D "' + ISNULL(@xFilePath,'') + '"';  
  
        INSERT dbo.U_dsi_BIM_ImportFileList (filFileName)  
        EXEC master.dbo.xp_cmdshell @FileCmd;  
      
        -- Remove NULL values from Table  
        DELETE FROM dbo.U_dsi_BIM_ImportFileList WHERE filFileName IS NULL;  
  
        -- Update FormatCode  
        UPDATE dbo.U_dsi_BIM_ImportFileList  
            SET filFormatCode = @xFormatCode  
        WHERE filFormatCode IS NULL AND filImported = 0;  
  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Loading Files: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
    -- Track Process Step - Load All FileNames from Specified "ImportPath"  
    SET @StepID += 1;  
    INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
    VALUES (@xFormatCode,@xExportCode,@StepID,'LOADFILENAMES','Load All FileNames from Specified "ImportPath"');  
  
    --================================================================================  
    -- Filter FileNames to be Imported  
    --================================================================================  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT '*** Filter Files to be Imported ***';  
        PRINT '';  
    END;  
    BEGIN TRY  
        -- No Multiple Files, Only Import Specified FileName  
        IF (@xMultipleFiles = 'N')  
        BEGIN  
            DELETE FROM dbo.U_dsi_BIM_ImportFileList WHERE filFormatCode = @xFormatCode AND filFileName <> @xFileName;  
        END  
  
        -- Multiple Files based on File Name Convention  
        IF (@xMultipleFiles = 'Y' AND NULLIF(@xFileName,'') IS NOT NULL)  
        BEGIN  
            SET @FileCmd = '';  
            SET @FileCmd = 'DELETE FROM dbo.U_dsi_BIM_ImportFileList WHERE filFormatCode = ''' + LTRIM(RTRIM(@xFormatCode)) + ''' AND filFileName NOT LIKE ''' + REPLACE(@xFileName,'*','%') + '''';  
  
            IF (@TestingFlag = 'Y')  
            BEGIN  
                PRINT @FileCmd;  
            END;  
  
            EXEC (@FileCmd)  
        END  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Filtering Files: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
    -- Track Process Step - Filter FileNames based on "FileName" Parameter  
    SET @StepID += 1;  
    INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
    VALUES (@xFormatCode,@xExportCode,@StepID,'FILTERFILENAMES','Filter FileNames based on "FileName" Parameter');  
  
    --================================================================================  
    -- Check If File Exists in the U_dsi_BIM_ImportFileList table (Error If No Files)  
    --================================================================================  
    IF NOT EXISTS(SELECT 1 FROM dbo.U_dsi_BIM_ImportFileList)  
    BEGIN  
        -- Return File Does Not Exist Error in IMPORT Table  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) VALUES (''File Name: "' + ISNULL(@xFileName,'') + '" Does Not Exist In File Path: "' + ISNULL(@xFilePath,'') + '". Import Cancelled.'')'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Stop Processing  
        RETURN;  
    END;  
  
    --================================================================================  
    -- Import All Files in the U_dsi_BIM_ImportFileList table  
    --================================================================================  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT '*** Load All Files into U_dsi_BIM_ImportFileList table for Processing ***';  
        PRINT '';  
    END;  
  
    DECLARE @RecordCount    SMALLINT = 1  
           ,@FileCount      SMALLINT = (SELECT COUNT(*) FROM dbo.U_dsi_BIM_ImportFileList WHERE filFormatCode = @xFormatCode)  
           ,@FileID         SMALLINT;  
  
    WHILE (@RecordCount <= @FileCount)  
    BEGIN  
  
        BEGIN TRY  
            --=================================================================  
            -- Set File Name and FileID for Bulk Insert to First File in List  
            --=================================================================  
            SELECT TOP 1 @xFileName = filFileName, @FileID = filID  
            FROM dbo.U_dsi_BIM_ImportFileList  
            WHERE filFormatCode = @xFormatCode AND filImported = 0  
            ORDER BY filID;  
  
            --=============================================  
            -- File Validation (Check if File Exists)  
            --=============================================  
  
            -- Check If File Exists  
            SET @xFileExists = dbo.dsi_BIM_fn_CheckFileExists (@xFilePath,@xFileName);  
  
            IF (@TestingFlag = 'Y')  
            BEGIN  
                PRINT '@xFileExists:  ' + convert(varchar(1),@xFileExists);  
            END;  
  
            -- Return Error If File Does Not Exist  
            IF (@xFileExists = 0)  
            BEGIN  
  
                -- Return File Does Not Exist Error in IMPORT Table  
                SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) VALUES (''File Name: "' + ISNULL(@xFileName,'') + '" Does Not Exist In File Path: "' + ISNULL(@xFilePath,'') + '". Import Cancelled.'')'  
  
                IF (@TestingFlag = 'Y')  
                BEGIN  
                    PRINT @xCMD;  
                END;  
  
                EXEC (@xCMD);  
  
                -- Stop Processing  
                RETURN;  
  
            END  
        END TRY  
        BEGIN CATCH  
            -- Report SQL Error in Error Report File  
            SET @xCMD = '';  
            SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Check if File Exists for File "' + ISNULL(@xFileName,'') + '": ' + ISNULL(ERROR_MESSAGE(),'');  
  
            -- Stop Processing  
            RETURN;  
        END CATCH;  
  
        --=============================================  
        -- Load File into _Raw and _Import Tables  
        --=============================================  
        IF (@xFileFormat = 'Delimited')  
        BEGIN TRY  
            IF (@TestingFlag = 'Y')  
            BEGIN  
                PRINT '';  
                PRINT '*** Process Delimited File: dbo.dsi_BIM_sp_LoadDelimitedFile ***';  
                PRINT '';  
            END;  
  
            EXEC dbo.dsi_BIM_sp_LoadDelimitedFile @xFormatCode, @xFileName, @StepID;  
  
            -- Track Process Step - Process Delimited File: dbo.dsi_BIM_sp_LoadDelimitedFile  
            SET @StepID += 1;  
            INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc,bimStepValue)  
            VALUES (@xFormatCode,@xExportCode,@StepID,'PROCESSDELIMITED','Process Delimited File: dbo.dsi_BIM_sp_LoadDelimitedFile',@xFileName);  
        END TRY  
        BEGIN CATCH  
            -- Report SQL Error in Error Report File  
            SET @xCMD = '';  
            SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Processing Delimited File: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
            -- Stop Processing  
            RETURN;  
        END CATCH;  
  
        IF (@xFileFormat = 'Fixed')  
        BEGIN TRY  
            IF (@TestingFlag = 'Y')  
            BEGIN  
                PRINT '';  
                PRINT '*** Process Fixed File: dbo.dsi_BIM_sp_LoadFixedFile ***';  
                PRINT '';  
            END;  
  
            EXEC dbo.dsi_BIM_sp_LoadFixedFile @xFormatCode, @xFileName, @StepID;  
  
            -- Track Process Step - Process Fixed File: dbo.dsi_BIM_sp_LoadFixedFile  
            SET @StepID += 1;  
            INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc,bimStepValue)  
            VALUES (@xFormatCode,@xExportCode,@StepID,'PROCESSFIXED','Process Fixed File: dbo.dsi_BIM_sp_LoadFixedFile',@xFileName);  
        END TRY  
        BEGIN CATCH  
            -- Report SQL Error in Error Report File  
            SET @xCMD = '';  
            SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Processing Fixed File: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
            -- Stop Processing  
            RETURN;  
        END CATCH;  
  
        --===================  
        -- Archive File(s)  
        --===================  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT '';  
            PRINT '*** Archive Files ***';  
            PRINT '';  
        END;  
  
        IF (@xArchiveFiles = 'Y')  
        BEGIN TRY  
  
            -- Declare Variables  
            DECLARE @ArchiveCmd VARCHAR(8000), @ArchivePath VARCHAR(200), @NewFileName VARCHAR(MAX);  
            SET @ArchivePath = dbo.Dsi_fnVariable(@xFormatCode,'ArchivePath');  
  
            IF (@TestingFlag = 'Y')  
            BEGIN  
                PRINT 'Archive Path: ' + ISNULL(@ArchivePath,'');  
     END;  
  
            -- Rename File Name to Append Date/Time Stamp: YYYYMMDDhhmmss  
            SET @NewFileName = @xFileName + '.' + CONVERT(CHAR(8),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0));  
  
            -- Rename Existing File to New FileName  
            SET @ArchiveCmd = '';  
            SET @ArchiveCmd = 'REN "' + @xFilePath + @xFileName + '" "' + @NewFileName + '"'  
  
            IF (@TestingFlag = 'Y')  
            BEGIN  
                PRINT @ArchiveCmd;  
            END;  
  
            EXEC master.dbo.xp_cmdshell @ArchiveCmd, NO_OUTPUT  
  
            -- Move Existing File to Archive Folder  
            SET @ArchiveCmd = '';  
            SET @ArchiveCmd = 'MOVE "' + @xFilePath + @NewFileName + '" "' + @ArchivePath + @NewFileName + '"'  
  
            IF (@TestingFlag = 'Y')  
            BEGIN  
                PRINT @ArchiveCmd;  
            END;  
  
            EXEC master.dbo.xp_cmdshell @ArchiveCmd, NO_OUTPUT  
  
            -- Set "filArchived" = 1 for Archiving  
            UPDATE dbo.U_dsi_BIM_ImportFileList  
                SET filArchived = 1  
            WHERE filFormatCode = @xFormatCode AND filID = @FileID;  
  
            -- Track Process Step - Archive Files  
            SET @StepID += 1;  
            INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc,bimStepValue)  
            VALUES (@xFormatCode,@xExportCode,@StepID,'ARCHIVEFILES','Archive Files',@xFileName);  
  
        END TRY  
        BEGIN CATCH  
            -- Report SQL Error in Error Report File  
            SET @xCMD = '';  
            SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Archiving Files: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
            -- Stop Processing  
            RETURN;  
        END CATCH;  
  
        --=========================================  
        -- Copy File(s) - Do Not Archive Original  
        --=========================================  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT '';  
            PRINT '*** Copy Files ***';  
            PRINT '';  
        END;  
        IF (@xCopyFiles = 'Y')  
        BEGIN TRY  
  
            -- Declare Variables  
            DECLARE @CopyCmd VARCHAR(8000), @CopyPath VARCHAR(200), @CopyFileName VARCHAR(MAX);  
            SET @CopyPath = dbo.Dsi_fnVariable(@xFormatCode,'ArchivePath');  
  
            IF (@TestingFlag = 'Y')  
            BEGIN  
                PRINT 'Copy Archive Path: ' + ISNULL(@CopyPath,'');  
            END;  
  
            -- Rename File Name to Append Date/Time Stamp: YYYYMMDDhhmmss  
            SET @CopyFileName = @xFileName + '.' + CONVERT(CHAR(8),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0));  
  
            -- Rename Existing File to New FileName  
            SET @CopyCmd = '';  
            SET @CopyCmd = 'COPY "' + @xFilePath + @xFileName + '" "' + @CopyPath + @CopyFileName + '"'  
  
            IF (@TestingFlag = 'Y')  
            BEGIN  
                PRINT @CopyCmd;  
            END;  
  
            EXEC master.dbo.xp_cmdshell @CopyCmd, NO_OUTPUT  
  
            -- Set "filArchived" = 1 for Archiving  
            UPDATE dbo.U_dsi_BIM_ImportFileList  
                SET filCopied = 1  
            WHERE filFormatCode = @xFormatCode AND filID = @FileID;  
  
            -- Track Process Step - Copy Files to Archive  
            SET @StepID += 1;  
            INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc,bimStepValue)  
            VALUES (@xFormatCode,@xExportCode,@StepID,'COPYFILES','Copy Files to Archive',@xFileName);  
        END TRY  
        BEGIN CATCH  
            -- Report SQL Error in Error Report File  
            SET @xCMD = '';  
            SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Copying Files to Archive: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
            -- Stop Processing  
            RETURN;  
        END CATCH;  
  
        --=============================================  
        -- Loop to Next File  
        --=============================================  
  
        -- Set "filImported" Flag = 1 to denote the file was imported, and "filArchived" = 1 for Archiving  
        UPDATE dbo.U_dsi_BIM_ImportFileList  
            SET filImported = 1  
        WHERE filFormatCode = @xFormatCode AND filID = @FileID;  
  
        -- Set @RecordCount to Next File  
        SET @RecordCount += 1;  
  
    END;  
  
    --=====================================================  
    -- Update EEID/COID Based on Combined Key ID Values  
    --=====================================================  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT '*** Update EEID/COID Based on Combined Key ID Values ***';  
        PRINT '';  
    END;  
  
    IF (NULLIF(@xKeyEEID,'') IS NOT NULL AND NULLIF(@xKeyCOID,'') IS NOT NULL)  
    BEGIN TRY  
        -- Update EEID/COID based on Actual EEID/COID in KeyEEID/KeyCOID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET EEID = EecEEID '  
                    + '   ,COID = EecCOID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.EmpComp WITH (NOLOCK) '  
                    + '  ON EecEEID = ' + @xKeyEEID + ' '  
                    + '  AND EecCOID = ' + @xKeyCOID + ' '  
                    + 'WHERE EEID IS NULL AND COID IS NULL;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Update EEID/COID based on SSN and Actual COID in KeyEEID/KeyCOID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET EEID = EepEEID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.EmpPers WITH (NOLOCK) '  
                    + '  ON dbo.dsi_fnPadZero(EepSSN,9,0) = dbo.dsi_fnPadZero(' + @xKeyEEID + ',9,0) '  
                    + '  AND EepHomeCOID = ' + @xKeyCOID + ' '  
                    + 'WHERE EEID IS NULL AND COID IS NULL AND ISNUMERIC(EepSSN) = 1 AND ISNUMERIC(' + @xKeyEEID + ') = 1 AND LEN(' + @xKeyEEID + ') = 9;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Update EEID/COID based on Employee# and Actual COID in KeyEEID/KeyCOID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET EEID = EecEEID '  
                    + '   ,COID = EecCOID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.EmpComp WITH (NOLOCK) '  
                    + '  ON CASE WHEN ISNUMERIC(EecEmpNo) = 1 THEN dbo.dsi_fnPadZero(EecEmpNo,9,0) ELSE EecEmpNo END = CASE WHEN ISNUMERIC(' + @xKeyEEID + ') = 1 THEN dbo.dsi_fnPadZero(' + @xKeyEEID + ',9,0) ELSE ' + @xKeyEEID + ' END '  
                    + '  AND EecCOID = ' + @xKeyCOID + ' '  
                    + 'WHERE EEID IS NULL AND COID IS NULL;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Update EEID/COID based on Employee# and CompanyCode in KeyEEID/KeyCOID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET EEID = EecEEID '  
                    + '   ,COID = EecCOID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.EmpComp WITH (NOLOCK) '  
                    + '  ON CASE WHEN ISNUMERIC(EecEmpNo) = 1 THEN dbo.dsi_fnPadZero(EecEmpNo,9,0) ELSE EecEmpNo END = CASE WHEN ISNUMERIC(' + @xKeyEEID + ') = 1 THEN dbo.dsi_fnPadZero(' + @xKeyEEID + ',9,0) ELSE ' + @xKeyEEID + ' END '  
                    + 'JOIN dbo.Company WITH (NOLOCK) '  
                    + '  ON CmpCompanyCode = LTRIM(RTRIM(' + @xKeyCOID + ')) '  
                    + '  AND EecCOID = CmpCOID '  
                    + 'WHERE EEID IS NULL AND COID IS NULL;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Track Process Step - Update EEID/COID Based on Combined Key ID Values  
        SET @StepID += 1;  
        INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
        VALUES (@xFormatCode,@xExportCode,@StepID,'UPDATEEEIDCOID','Update EEID/COID Based on Combined Key ID Values');  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error EEID Assignment: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
    --=============================================  
    -- Update EEID Based on Key ID Values  
    --=============================================  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT '*** Update EEID Based on Key ID Values ***';  
        PRINT '';  
    END;  
  
    IF (NULLIF(@xKeyEEID,'') IS NOT NULL AND NULLIF(@xKeyCOID,'') IS NULL)  
    BEGIN TRY  
        -- Update EEID based on actual KeyEEID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET EEID = EecEEID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.EmpComp WITH (NOLOCK) '  
                    + '  ON EecEEID = ' + @xKeyEEID + ' '  
                    + 'WHERE EEID IS NULL;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Update EEID based on SSN in KeyEEID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET EEID = EepEEID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.EmpPers WITH (NOLOCK) '  
                    + '  ON dbo.dsi_fnPadZero(EepSSN,9,0) = dbo.dsi_fnPadZero(' + @xKeyEEID + ',9,0) '  
                    + 'WHERE EEID IS NULL AND ISNUMERIC(EepSSN) = 1 AND ISNUMERIC(' + @xKeyEEID + ') = 1 AND LEN(' + @xKeyEEID + ') = 9;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Update EEID based on Employee# in KeyEEID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET EEID = EecEEID '  
                    + '   ,COID = EecCOID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.EmpComp WITH (NOLOCK) '  
                    + '  ON CASE WHEN ISNUMERIC(EecEmpNo) = 1 THEN dbo.dsi_fnPadZero(EecEmpNo,9,0) ELSE EecEmpNo END = CASE WHEN ISNUMERIC(' + @xKeyEEID + ') = 1 THEN dbo.dsi_fnPadZero(' + @xKeyEEID + ',9,0) ELSE ' + @xKeyEEID + ' END '  
                    + '  AND EecCOID = dbo.dsi_BDM_fn_GetCurrentCOID (EecEEID) '  
                    + 'WHERE EEID IS NULL;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        --Update COID based on EmpComp EEID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET COID = EecCOID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.EmpComp WITH (NOLOCK) '  
                    + '  ON EecEEID = EEID '  
                    + '  AND EecCOID = dbo.dsi_BDM_fn_GetCurrentCOID (EecEEID) '  
                    + 'WHERE COID IS NULL;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error EEID Assignment: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
    --=============================================  
    -- Update COID Based on Key ID Values  
    --=============================================  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT '*** Update COID Based on Key ID Values ***';  
        PRINT '';  
    END;  
  
    IF (NULLIF(@xKeyCOID,'') IS NOT NULL)  
    BEGIN TRY  
        -- Update COID based on actual KeyCOID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET COID = CmpCOID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.Company WITH (NOLOCK) '  
                    + '  ON CmpCOID = ' + @xKeyCOID + ' '  
                    + 'WHERE COID IS NULL;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Update COID based on CompanyCode in KeyCOID  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET COID = CmpCOID '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'JOIN dbo.Company WITH (NOLOCK) '  
                    + '  ON CmpCompanyCode = LTRIM(RTRIM(' + @xKeyCOID + ')) '  
                    + 'WHERE COID IS NULL;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Track Process Step - Update COID Based on Key ID Values  
        SET @StepID += 1;  
        INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
        VALUES (@xFormatCode,@xExportCode,@StepID,'UPDATECOID','Update COID Based on Key ID Values');  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error COID Assignment: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
    --============================================================================  
    -- Update Employee Name, Employee#, Company Codes based on EEID/COID Values  
    --============================================================================  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT '*** Update Employee Name, Employee#, Company Codes based on EEID/COID Values ***';  
        PRINT '';  
    END;  
    BEGIN TRY  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET EmployeeNo = RTRIM(EecEmpNo) '  
                    + '   ,EmployeeName = RTRIM(EepNameFirst) + SPACE(1) + RTRIM(EepNameLast) '  
                    + '   ,CompanyCode = RTRIM(CmpCompanyCode) '  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'LEFT JOIN dbo.EmpPers WITH (NOLOCK) '  
                    + '  ON EepEEID = EEID '  
                    + 'LEFT JOIN dbo.Company WITH (NOLOCK) '  
                    + '  ON CmpCOID = COID '  
                    + 'LEFT JOIN dbo.EmpComp WITH (NOLOCK) '  
                    + '  ON EecEEID = EEID '  
                    + '  AND EecCOID = COID; '  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Track Process Step - Update Employee Name, Employee#, Company Codes based on EEID/COID Values  
        SET @StepID += 1;  
        INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
        VALUES (@xFormatCode,@xExportCode,@StepID,'UPDATENAMECOMPANY','Update Employee Name, Employee#, Company Codes based on EEID/COID Values');  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Updating _Import with EEID/COID Assignments: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
         
    --==============================================  
    -- Calculate Pay Period Start Date by Employee  
    --==============================================  
    BEGIN TRY  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT '';  
            PRINT '*** Calculate Pay Period Start Date by Employee: dbo.dsi_BIM_sp_CalcPayrollDate ***';  
            PRINT '';  
        END;  
  
        EXEC dbo.dsi_BIM_sp_CalcPayrollDate @xFormatCode, @StepID;  
  
        -- Track Process Step - Calculate Pay Period Start Date by Employee  
        SET @StepID += 1;  
        INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
        VALUES (@xFormatCode,@xExportCode,@StepID,'CALCPAYDATES','Calculate Pay Period Start Date by Employee: dbo.dsi_BIM_sp_CalcPayrollDate');  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT ''Error Calculating Payroll Dates: ''' + ISNULL(ERROR_MESSAGE(),'');  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
    -- Track Process Step - End BIM Code  
    SET @StepID += 1;  
    INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
    VALUES (@xFormatCode,@xExportCode,@StepID,'ENDBIM','End BIM Code');  
  
END