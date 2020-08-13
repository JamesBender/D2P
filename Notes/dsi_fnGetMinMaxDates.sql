/****** Object:  UserDefinedFunction [dbo].[dsi_fnGetMinMaxDates]    Script Date: 6/16/2020 8:45:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[dsi_fnGetMinMaxDates] (
    @Type  VARCHAR(3), 
    @Date1 DATETIME,
    @Date2 DATETIME
)
RETURNS DATETIME
WITH EXECUTE AS CALLER
AS
/************************************************************
 
Created By: Erin Hidalgo & John Transier
Create Date: 08-25-08
 
Purpose: Returns the minimum or maximum of two input dates
 
Command: PRINT dbo.dsi_fnGetMinMaxDates('MIN', GETDATE(), GETDATE() +1 )
 
NOTE TO SUPPORT: this function is one of a standard set of USI functions. Please do not make any changes
to this function without going through the USI team. Any changes made to this function will be wiped out
if/when the standard USI code is reinstalled on this database.
 
Revision History
----------------
Update By         Date          CP Num         Descr
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx
 
************************************************************/
BEGIN
 
IF @Date1 IS NULL AND @Date2 IS NULL RETURN NULL;
IF @Date1 IS NULL                    RETURN @Date2;
IF @Date2 IS NULL                    RETURN @Date1;
IF @Date1 = @Date2                   RETURN @Date1;
 
RETURN CASE 
          WHEN @Type = 'MIN' AND @Date1 < @Date2 THEN @Date1 
          WHEN @Type = 'MIN' AND @Date1 > @Date2 THEN @Date2 
          WHEN @Type = 'MAX' AND @Date1 > @Date2 THEN @Date1 
          WHEN @Type = 'MAX' AND @Date1 < @Date2 THEN @Date2 
       END;
 
RETURN NULL;
 
END
