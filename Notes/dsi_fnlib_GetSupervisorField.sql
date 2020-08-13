/****** Object:  UserDefinedFunction [dbo].[dsi_fnlib_GetSupervisorField]    Script Date: 1/20/2020 12:13:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE OR ALTER FUNCTION [dbo].[dsi_fnlib_GetSupervisorField] (    
@COID            VARCHAR(5),    
@EEID            VARCHAR(12),    
@FieldName       VARCHAR(32)    
)    
    
RETURNS VARCHAR(256)    
WITH EXECUTE AS CALLER    
AS    
    
/************************************************************    
    
Created By: John Transier    
Create Date: 08/16/2017    
    
Revision History    
----------------    
Update By            Date            Desc    
John Transier        10/16/2019      Added suffix, EecUDField01, JobCode    
    
Purpose: Pulls basic supervisor fields for an employee, e.g. name, employee number.    
    
Description    
-----------    
Pulls basic supervisor fields, e.g. name, employee number. If COID is left blank it will pull the employee's current COID.    
    
    
Commands    
--------    
SELECT    
    
EecEEID,    
EecSupervisorID,    
dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast, First')    
    
FROM dbo.EmpComp    
    
************************************************************/    
    
BEGIN    
    
-----------    
-- Declare and set variables    
-----------    
    
DECLARE @Return         VARCHAR(256)    
DECLARE @SupervisorCOID VARCHAR(5)    
DECLARE @SupervisorEEID VARCHAR(12)    
    
SET @COID      = LTRIM(RTRIM(COALESCE(@COID, '')))    
SET @EEID      = LTRIM(RTRIM(COALESCE(@EEID, '')))    
SET @FieldName = LTRIM(RTRIM(COALESCE(@FieldName, '')))    
    
IF @EEID      = '' RETURN ''    
IF @FieldName = '' RETURN ''    
    
IF @COID = '' SET @COID = dbo.dsi_fn_GetCurrentCOID(@EEID)    
    
    
-----------    
-- Set supervisor fields    
-----------    
    
SELECT    
    
@SupervisorEEID = LTRIM(RTRIM(COALESCE(EecSupervisorID, ''))),    
@SupervisorCOID = dbo.dsi_fn_GetCurrentCOID(EecSupervisorID)    
    
FROM dbo.EmpComp    
WHERE EecCOID = @COID    
  AND EecEEID = @EEID    
    
IF @SupervisorEEID = '' RETURN ''    
    
    
-----------    
-- Get supervisor data    
-----------    
    
SELECT @Return = CASE    
                    WHEN @FieldName = 'SSN'                       THEN EepSSN    
                    WHEN @FieldName = 'NameFirst'                 THEN EepNameFirst    
                    WHEN @FieldName = 'NameLast'                  THEN EepNameLast    
                    WHEN @FieldName = 'NameMiddle'                THEN EepNameMiddle    
                    WHEN @FieldName = 'NameMiddleInit'            THEN LEFT(EepNameMiddle, 1)    
                    WHEN @FieldName = 'NameLast, First'           THEN LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst))    
                    WHEN @FieldName = 'NameLast, First M'         THEN LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + COALESCE(LEFT(EepNameMiddle, 1), '')    
                    WHEN @FieldName = 'NameFirst Last'            THEN LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(EepNameLast))    
                    WHEN @FieldName = 'NameFML'                   THEN LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(COALESCE(EepNameMiddle, ''))) + ' ' + LTRIM(RTRIM(EepNameLast))    
                    WHEN @FieldName = 'Suffix'                    THEN IIF(COALESCE(EepNameSuffix, '') IN ('', 'Z'), '', LTRIM(RTRIM(EepNameSuffix)))    
                    WHEN @FieldName = 'AddressEMail'              THEN EepAddressEMail    
                    WHEN @FieldName = 'PhoneHomeNumber'           THEN EepPhoneHomeNumber    
                    WHEN @FieldName = 'EmpNo'                     THEN EecEmpNo    
                    WHEN @FieldName = 'Status'                    THEN EecEmplStatus    
                    WHEN @FieldName = 'JobCode'                   THEN EecJobCode    
                    WHEN @FieldName = 'JobDesc'                   THEN JbcDesc    
                    WHEN @FieldName = 'COID'                      THEN @SupervisorCOID    
                    WHEN @FieldName = 'EEID'                      THEN @SupervisorEEID    
                    WHEN @FieldName = 'EecUDField01'              THEN EecUDField01    
                    WHEN @FieldName = 'BusinessPhoneNumber'       THEN EecPhoneBusinessNumber    
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
    
    
    
    
    