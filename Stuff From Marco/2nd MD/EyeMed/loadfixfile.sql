CREATE PROCEDURE [dbo].[dsi_BIM_sp_LoadFixedFile]  
     @FormatCode VARCHAR(10)  
    ,@FileName VARCHAR(500)  
    ,@StepID DECIMAL(5,2)  
AS  
SET NOCOUNT ON;  
/**********************************************************************************  
  
Created By: Tanya Leonce  
Create Date: 02/01/2017  
  
Purpose: Performs BULK INSERT and Loads _Import File for Fixed File Format  
  
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
    -- Declare Variables  
    --=============================================  
    DECLARE @xFormatCode        VARCHAR(10);  
    DECLARE @xExportCode        VARCHAR(10);  
    DECLARE @xFilePath          VARCHAR(500);  
    DECLARE @xFileName          VARCHAR(500);  
    DECLARE @xCMD               VARCHAR(8000);  
    DECLARE @xFieldCount        INT;  
    DECLARE @AddToPreviousRun   VARCHAR(1);  
    DECLARE @RunID              VARCHAR(50);  
    DECLARE @xKeyEEID           VARCHAR(50);  
    DECLARE @rCount             INT;  
    DECLARE @srcPath            VARCHAR(1000);  
    DECLARE @xStepID            DECIMAL(5,2);  
    DECLARE @TestingFlag        VARCHAR(1);  
  
    SET @xFormatCode            = @FormatCode;  
    SET @xStepID                = @StepID;  
    SET @xCMD                   = '';  
    SET @xExportCode            = (SELECT ExportCode FROM dbo.U_dsi_Parameters WHERE FormatCode = @xFormatCode);  
    SET @xFilePath              = (SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'FilePath');  
    SET @xFileName              = @FileName;  
    SET @xKeyEEID               = (SELECT TOP 1 ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'KeyEEID');  
    SET @xFieldCount            = (SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'FieldCount');  
    SET @AddToPreviousRun       = COALESCE((SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'AddToPreviousRun'),'N');  
    SET @RunID                  = (SELECT ParmValue1 FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @xFormatCode AND ParmName = 'RunID');  
    SET @TestingFlag            = dbo.dsi_fnVariable(@FormatCode,'Testing');  
      
    -- Clean File Name (Remove Path) and File Path  
    SET @xFileName = dbo.dsi_BIM_fn_CleanFileName (@xFileName);  
    SET @xFilePath = dbo.dsi_BIM_fn_FormatFilePath(@xFilePath);  
  
    -- Set Source PAth  
    SET @srcPath = ISNULL(RTRIM(@xFilePath),'') + ISNULL(LTRIM(@xFileName),'');  
  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '@srcPath: ' + ISNULL(@srcPath,'');  
    END;  
  
    -- Track Process Step - Declare and Set Initial Variables  
    SET @xStepID += 0.01;  
    INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
    VALUES (@xFormatCode,@xExportCode,@xStepID,'DECLAREVARIABLES','Declare and Set Initial Variables');  
  
    --=============================================================================================  
    -- Dynamically Create File Layout based on Start Position and Length (Add Fillers As Needed)  
    --=============================================================================================  
  
    ------------------------------  
    -- Clear File Layout Table  
    ------------------------------  
    IF (@AddToPreviousRun <> 'Y')  
    BEGIN  
        IF (@TestingFlag = 'Y')  
        BEGIN  
      PRINT '';  
            PRINT 'Clear File Layout Table';  
            PRINT '';  
        END;  
  
        DELETE FROM dbo.U_dsi_BIM_FileLayout WHERE fFormatCode = @xFormatCode;  
    END  
  
    ------------------------------  
    -- Load File Layout Table  
    ------------------------------  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT 'Load File Layout Table';  
        PRINT '';  
    END;  
    BEGIN TRY  
        INSERT INTO dbo.U_dsi_BIM_FileLayout (fFormatCode,fRunID,fRowNo,fDescription,fStartPos,fEndPos,fLength,fPrevEndPos)  
        SELECT fFormatCode = @xFormatCode  
            ,fRunID = @RunID  
            ,fRowNo = COALESCE(ParmValue1,CONVERT(SMALLINT,ROW_NUMBER() OVER (ORDER BY CONVERT(SMALLINT,ParmValue2))))  
            ,fDescription = ParmValue4  
            ,fStartPos = CONVERT(SMALLINT,ParmValue2)  
            ,fEndPos = (CONVERT(SMALLINT,ParmValue2) + CONVERT(SMALLINT,ParmValue3)) - 1  
            ,fLength = CONVERT(SMALLINT,ParmValue3)  
            ,fPrevEndPos = LAG((CONVERT(SMALLINT,ParmValue2) + CONVERT(SMALLINT,ParmValue3)) - 1) OVER (ORDER BY (CONVERT(SMALLINT,ParmValue2) + CONVERT(SMALLINT,ParmValue3)) - 1)  
        FROM dbo.U_dsi_BIM_Configuration  
        WHERE FormatCode = @xFormatCode AND ParmName = 'FixedLayout';  
  
        -- Track Process Step - Load File Layout Table  
        SET @xStepID += 0.01;  
        INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
        VALUES (@xFormatCode,@xExportCode,@xStepID,'LOADFIXEDLAYOUT','Load File Layout Table');  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        INSERT INTO dbo.U_dsi_BIM_Errors (eFormatCode,eError) VALUES (@xFormatCode, 'Error Loading Fixed File Layout: ' + ISNULL(ERROR_MESSAGE(),''));  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT DISTINCT eError FROM dbo.U_dsi_BIM_Errors WHERE eFormatCode = ''' + @xFormatCode + '''';  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
    --=============================================  
    -- Create RAW Table and BULK INSERT  
    --=============================================  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT 'Create _Raw Table / Perform BULK INSERT';  
        PRINT '';  
    END;  
    BEGIN TRY  
  
        -- Update Field Count based on File Layout with Fillers  
        SET @xFieldCount = (SELECT COUNT(*) FROM dbo.U_dsi_BIM_FileLayout WHERE fFormatCode = @xFormatCode AND (@AddToPreviousRun <> 'Y' OR (@AddToPreviousRun = 'Y' AND fRunID = @RunID)));  
  
        --------------------------------------------------------------------------  
        -- Create RAW Table with Data Column for Fixed Width/Fixed Length Files  
        --------------------------------------------------------------------------  
  
        -- Drop _Raw Table  
        SET @xCMD = 'IF OBJECT_ID(''U_' + @xFormatCode + '_Raw'',''U'') IS NOT NULL DROP TABLE dbo.U_' + @xFormatCode + '_Raw; '  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Create Raw Table  
        SET @xCMD = 'CREATE TABLE dbo.U_' + @xFormatCode + '_Raw (Data VARCHAR(MAX));';  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        ------------------------------------------  
        -- BULK INSERT STATEMENT INTO _Raw Table  
        ------------------------------------------  
        -- NOTE: Set FIRSTROW = 2, If Header Exists In Import File (Header Row is Skipped)  
        -- Set Row Terminator to Line Feed (LF): ROWTERMINATOR = ''0x0a''  
        SELECT @xCMD = 'BULK INSERT '+ RTRIM(DB_NAME()) + '.dbo.U_' + @xFormatCode + '_Raw '  
                        + 'FROM ''' + @srcPath + ''' '  
                        + 'WITH (FIRSTROW = 1, ROWTERMINATOR = ''0x0a'')';  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Track Process Step - Create _Raw Table / Perform BULK INSERT  
        SET @xStepID += 0.01;  
        INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
        VALUES (@xFormatCode,@xExportCode,@xStepID,'BULKINSERT','Create _Raw Table / Perform BULK INSERT');  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        INSERT INTO dbo.U_dsi_BIM_Errors (eFormatCode,eError) VALUES (@xFormatCode, 'Error Importing Fixed File: ' + ISNULL(ERROR_MESSAGE(),''));  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT DISTINCT eError FROM dbo.U_dsi_BIM_Errors WHERE eFormatCode = ''' + @xFormatCode + '''';  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
    --=============================================  
    -- Load Import Table  
    --=============================================  
    IF (@TestingFlag = 'Y')  
    BEGIN  
        PRINT '';  
        PRINT 'Load _Import Table';  
        PRINT '';  
    END;  
    BEGIN TRY  
  
        -- Initialize INSERT Statement  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (EEID, COID, RunID, Error ';  
  
        SELECT @xCMD = @xCMD + ',Field' + CONVERT(VARCHAR(5),fRowNo) + ' '  
        FROM dbo.U_dsi_BIM_FileLayout WHERE fFormatCode = @FormatCode AND (@AddToPreviousRun <> 'Y' OR (@AddToPreviousRun = 'Y' AND fRunID = @RunID))  
        ORDER BY fRowNo;  
  
        SET @xCMD = @xCMD + ') '  
                    + 'SELECT EEID = CONVERT(CHAR(12),NULL) '  
                    + ',COID = CONVERT(CHAR(5),NULL) '  
                    + ',RunID = CONVERT(VARCHAR(50),''' + ISNULL(@RunID,'') + ''') '  
                    + ',Error = CONVERT(VARCHAR(250),NULL) ';  
  
        SELECT @xCMD = @xCMD + ',Field' + CONVERT(VARCHAR(5),fRowNo) + ' = REPLACE(SUBSTRING(Data,' + CONVERT(VARCHAR(5),fStartPos) + ',' + CONVERT(VARCHAR(5),fLength) + '),CHAR(13),SPACE(0)) '  
        FROM dbo.U_dsi_BIM_FileLayout WHERE fFormatCode = @FormatCode AND (@AddToPreviousRun <> 'Y' OR (@AddToPreviousRun = 'Y' AND fRunID = @RunID))  
        ORDER BY fRowNo;  
  
        -- Update   
        SET @xCMD = @xCMD + 'FROM dbo.U_' + @xFormatCode + '_Raw;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Update KeyEEID to remove '-' for SSN Values  
        SET @xCMD = 'UPDATE dbo.U_' + @xFormatCode + '_Import '  
                    + 'SET ' + @xKeyEEID + ' = REPLACE(' + @xKeyEEID + ',''-'',SPACE(0))'  
                    + 'FROM dbo.U_' + @xFormatCode + '_Import '  
                    + 'WHERE ISNUMERIC(REPLACE(' + @xKeyEEID + ',''-'',SPACE(0))) = 1 AND LEN(REPLACE(' + @xKeyEEID + ',''-'',SPACE(0))) = 9;'  
  
        IF (@TestingFlag = 'Y')  
        BEGIN  
            PRINT @xCMD;  
        END;  
  
        EXEC (@xCMD);  
  
        -- Track Process Step - Load Import Table  
        SET @xStepID += 0.01;  
        INSERT INTO dbo.U_dsi_BIM_Processes (bimFormatCode,bimExportCode,bimStepID,bimStepName,bimStepDesc)  
        VALUES (@xFormatCode,@xExportCode,@xStepID,'LOADIMPORTTABLE','Load Import Table');  
    END TRY  
    BEGIN CATCH  
        -- Report SQL Error in Error Report File  
        INSERT INTO dbo.U_dsi_BIM_Errors (eFormatCode,eError) VALUES (@xFormatCode, 'Error Parsing Fixed File: ' + ISNULL(ERROR_MESSAGE(),''));  
        SET @xCMD = '';  
        SET @xCMD = 'INSERT INTO dbo.U_' + @xFormatCode + '_Import (Error) SELECT DISTINCT eError FROM dbo.U_dsi_BIM_Errors WHERE eFormatCode = ''' + @xFormatCode + '''';  
  
        -- Stop Processing  
        RETURN;  
    END CATCH;  
  
END