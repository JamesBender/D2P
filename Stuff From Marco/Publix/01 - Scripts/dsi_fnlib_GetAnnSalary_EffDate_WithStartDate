  
CREATE FUNCTION [dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate] (  
 @EEID            VARCHAR(12),  
 @COID            VARCHAR(5),  
 @StartDate       DATETIME,  
 @DefaultDate     DATETIME  
)  
  
RETURNS DATETIME  
WITH EXECUTE AS CALLER  
AS  
  
/************************************************************  
  
Created By: Bill Sunderland, based on function written by Megan Cummings  
Create Date: 07/03/2018  
  
Revision History  
----------------  
Update By            Date            Desc  
  
  
Purpose: Gets the employee's annual salary effective date that is less than the "Start Date" used,   
if COID is left blank it will scan all rows for that employee.  
           
EXAMPLE:  
SELECT EecEEID, EecCOID, EecAnnSalary, dbo.dsi_fnlib_GetAnnSalary_EffDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire)   
FROM dbo.EmpComp ;  
  
  
************************************************************/  
  
BEGIN  
  
 -----------  
 -- Declare and set variables  
 -----------  
  
 DECLARE @EffDate DATETIME;  
  
 SET @EEID = LTRIM(RTRIM(COALESCE(@EEID, '')))  
 SET @COID = LTRIM(RTRIM(COALESCE(@COID, '')))  
  
 IF @EEID = '' RETURN NULL;  
  
  
 -----------  
 -- Find Rate Change Eff Date from Job History  
 -----------  
  
   SELECT @EffDate = MAX(EjhJobEffDate)  
  FROM dbo.EmpHJob   
 WHERE EjhEEID = @EEID   
   AND EjhCOID = CASE WHEN @COID <> '' THEN @COID ELSE EjhCOID END  
      AND EjhJobEffDate < @StartDate  
   AND EjhIsRateChange = 'Y';  
  
  
 -----------  
 -- Default if no date found in range  
 -----------  
  
 RETURN COALESCE(@EffDate, @DefaultDate)  
  
END  