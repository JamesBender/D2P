  
CREATE FUNCTION [dbo].[dsi_fnlib_GetSupervisorField_v2] (  
@COID            VARCHAR(5),  
@EEID            VARCHAR(12),  
@FieldName       VARCHAR(32)  
)  
  
RETURNS VARCHAR(256)  
WITH EXECUTE AS CALLER  
AS  
  
/************************************************************  
  
Created By: John Transier  
Create Date: 09/19/2017  
  
Revision History  
----------------  
Update By            Date            Desc  
XXXX                 XX/XX/16        Added 1234  
  
Purpose: Pulls basic data for the employee's latest active supervisor  
           
Description  
-----------  
Pulls basic supervisor fields, e.g. name, employee number. If COID is left blank it will pull the employee's current COID.  
Note this differs from dsi_fnlib_GetSupervisorField in that if the employee's supervisor is termed, it will loop through the  
employee's chain of command until it finds an active supervisor.  
  
Commands   
--------  
SELECT   
  
EecEEID,   
EecSupervisorID,  
dbo.dsi_fnlib_GetSupervisorField_v2('', EecEEID, 'NameLast, First')   
  
FROM dbo.EmpComp  
WHERE COALESCE(EecSupervisorID, '') <> ''  
  
************************************************************/  
  
BEGIN  
  
-----------  
-- Declare and set variables  
-----------  
  
DECLARE @Return           VARCHAR(256)  
DECLARE @SupervisorCOID   VARCHAR(5)  
DECLARE @SupervisorEEID   VARCHAR(12)  
DECLARE @SupervisorStatus CHAR(1)  
DECLARE @Cnt              INT  
  
SET @COID      = LTRIM(RTRIM(COALESCE(@COID, '')))  
SET @EEID      = LTRIM(RTRIM(COALESCE(@EEID, '')))  
SET @FieldName = LTRIM(RTRIM(COALESCE(@FieldName, '')))  
  
IF @EEID      = '' RETURN ''  
IF @FieldName = '' RETURN ''  
  
IF @COID = '' SET @COID = dbo.dsi_fn_GetCurrentCOID(@EEID)   
  
  
-----------  
-- Set supervisor fields for active supervisor  
-----------  
  
SET @Cnt = 0  
  
WHILE 1=1 BEGIN  
  
   -- If we haven't found an active supervisor in 20 iterations, return blank  
     
   SET @Cnt = @Cnt + 1  
   IF @Cnt > 20 RETURN ''  
  
  
   SELECT   
  
   @SupervisorEEID = LTRIM(RTRIM(COALESCE(EecSupervisorID, ''))),  
   @SupervisorCOID = dbo.dsi_fn_GetCurrentCOID(EecSupervisorID)  
     
   FROM dbo.EmpComp  
   WHERE EecCOID = @COID  
     AND EecEEID = @EEID  
  
   IF @SupervisorEEID = '' RETURN ''  
  
   SELECT @SupervisorStatus = EecEmplStatus  
     FROM dbo.EmpComp  
 WHERE EecCOID = @SupervisorCOID  
   AND EecEEID = @SupervisorEEID  
  
   IF @SupervisorStatus NOT IN ('T', '') BREAK  
  
  
   -- No luck, try again  
  
   SET @COID = @SupervisorCOID  
   SET @EEID = @SupervisorEEID  
  
END  
  
  
  
-----------  
-- Get supervisor data  
-----------  
  
SELECT @Return = CASE  
                    WHEN @FieldName = 'SSN'             THEN EepSSN  
                    WHEN @FieldName = 'NameFirst'       THEN EepNameFirst  
                    WHEN @FieldName = 'NameLast'        THEN EepNameLast  
                    WHEN @FieldName = 'NameMiddle'      THEN EepNameMiddle  
                    WHEN @FieldName = 'NameMiddleInit'  THEN LEFT(EepNameMiddle, 1)  
                    WHEN @FieldName = 'NameLast, First' THEN LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst))  
                    WHEN @FieldName = 'NameFirst Last'  THEN LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(EepNameLast))  
                    WHEN @FieldName = 'AddressEMail'    THEN EepAddressEMail  
                    WHEN @FieldName = 'EmpNo'           THEN EecEmpNo  
                    WHEN @FieldName = 'Status'          THEN EecEmplStatus  
                    WHEN @FieldName = 'JobDesc'         THEN JbcDesc  
                    WHEN @FieldName = 'COID'            THEN @SupervisorCOID 
                    WHEN @FieldName = 'Count'            THEN @Cnt 

     ELSE ''  
     END  
FROM EmpPers  
JOIN EmpComp WITH (NOLOCK) ON EecEEID = EepEEID AND EecCOID = @SupervisorCOID  
JOIN dbo.JobCode WITH (NOLOCK) ON JbcJobCode = EecJobCode  
WHERE EepEEID = @SupervisorEEID  
  
  
-----------  
-- Return  
-----------  
  
RETURN LTRIM(RTRIM(COALESCE(@Return, '')))  
  
END  
  
  
  
  
  
  
  
  