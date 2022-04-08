USE [ULTIPRO_SRGY]
GO
/****** Object:  UserDefinedFunction [dbo].[dsi_fnlib_JobHistoryTable_v2]    Script Date: 4/1/2022 8:58:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[dsi_fnlib_JobHistoryTable_v2] (@Fields VARCHAR(256))  
RETURNS @tblResult TABLE (RowID          INT,  
                          COID           VARCHAR(5)   NOT NULL,  
                          EEID           VARCHAR(12)  NOT NULL,  
                          FieldName      VARCHAR(128) NULL,  
                          OldValue       VARCHAR(128) NULL,  
                          NewValue       VARCHAR(128) NULL,  
                          EffDate        DATE         NULL)  
AS  
  
/************************************************************  
  
dsi_fnlib_JobHistoryTable_v2  
  
Created By: John Transier & Tanya Leonce  
Create Date: 05/09/2017  
  
Purpose: Creates an effective-dated job history table for one more EmpHJob fields.  
  
SELECT * FROM dbo.dsi_fnlib_JobHistoryTable_v2(' ') WHERE EEID = '23E1J1000080' ORDER BY EEID, EffDate DESC  
  
  
Revision History  
----------------  
Update By         Date          CP Num         Descr  
John Transier     06/21/2017    N/A            Changed sort to AuditKey only in case of back-dating  
Vinny Kelly       10/01/2018    N/A            Added FLSA Category to field list
Marie Thomerson   04/01/2022    N/A            Added Job Group Code to field list

************************************************************/  
  
BEGIN  
  
  
SET @Fields = LTRIM(RTRIM(COALESCE(@Fields, '')))  
  
  
  
-----------  
-- EjhPayGroup  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhPayGroup',  
LAG(CONVERT(VARCHAR(32), EjhPayGroup), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhPayGroup),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhPayGroup%'  
  
  
-----------  
-- EjhAnnSalary  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhAnnSalary',  
LAG(CONVERT(VARCHAR(32), EjhAnnSalary), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhAnnSalary),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhAnnSalary%'  
  
  
-----------  
-- EjhFullTimeOrPartTime  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhFullTimeOrPartTime',  
LAG(CONVERT(VARCHAR(32), EjhFullTimeOrPartTime), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhFullTimeOrPartTime),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhFullTimeOrPartTime%'  
  
  
-----------  
-- EjhEEType  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhEEType',  
LAG(CONVERT(VARCHAR(32), EjhEEType), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhEEType),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhEEType%'  
  
  
-----------  
-- EjhHourlyPayRate  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhHourlyPayRate',  
LAG(CONVERT(VARCHAR(32), EjhHourlyPayRate), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhHourlyPayRate),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhHourlyPayRate%'  
  
  
-----------  
-- EjhJobCode  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhJobCode',  
LAG(CONVERT(VARCHAR(32), EjhJobCode), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhJobCode),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhJobCode%'  
  
-----------  
-- EjhJobGroupCode  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhJobGroupCode',  
LAG(CONVERT(VARCHAR(32), EjhJobGroupCode), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhJobGroupCode),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhJobGroupCode%'  
    
-----------  
-- EjhLocation  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhLocation',  
LAG(CONVERT(VARCHAR(32), EjhLocation), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhLocation),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhLocation%'  
  
  
-----------  
-- EjhOrgLvl1  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhOrgLvl1',  
LAG(CONVERT(VARCHAR(32), EjhOrgLvl1), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhOrgLvl1),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhOrgLvl1%'  
  
  
-----------  
-- EjhOrgLvl2  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhOrgLvl2',  
LAG(CONVERT(VARCHAR(32), EjhOrgLvl2), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhOrgLvl2),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhOrgLvl2%'  
  
  
-----------  
-- EjhOrgLvl3  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhOrgLvl3',  
LAG(CONVERT(VARCHAR(32), EjhOrgLvl3), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhOrgLvl3),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhOrgLvl3%'  
  
  
-----------  
-- EjhOrgLvl4  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhOrgLvl4',  
LAG(CONVERT(VARCHAR(32), EjhOrgLvl4), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhOrgLvl4),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhOrgLvl4%'  
  
  
-----------  
-- EjhSupervisorID  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhSupervisorID',  
LAG(CONVERT(VARCHAR(32), EjhSupervisorID), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhSupervisorID),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhSupervisorID%'  
  
  
-----------  
-- EjhScheduledWorkHours  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhScheduledWorkHours',  
LAG(CONVERT(VARCHAR(32), EjhScheduledWorkHours), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhScheduledWorkHours),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhScheduledWorkHours%'  
  
  
-----------  
-- EjhPayGroup  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhPayGroup',  
LAG(CONVERT(VARCHAR(32), EjhPayGroup), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhPayGroup),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhPayGroup%'  
  
  
-----------  
-- EjhPayPeriod  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhPayPeriod',  
LAG(CONVERT(VARCHAR(32), EjhPayPeriod), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhPayPeriod),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhPayPeriod%'  
  
  
-----------  
-- EjhSalaryGrade  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhSalaryGrade',  
LAG(CONVERT(VARCHAR(32), EjhSalaryGrade), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhSalaryGrade),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhSalaryGrade%'  
  
  
-----------  
-- EjhSalaryOrHourly  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhSalaryOrHourly',  
LAG(CONVERT(VARCHAR(32), EjhSalaryOrHourly), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhSalaryOrHourly),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhSalaryOrHourly%'  

-----------  
-- EjhFLSACategory  
-----------  
  
INSERT INTO @tblResult  
SELECT DISTINCT  
  
ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
EjhCOID,  
EjhEEID,  
'EjhFLSACategory',  
LAG(CONVERT(VARCHAR(32), EjhFLSACategory), 1, '') OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY AuditKey),  
CONVERT(VARCHAR(32), EjhFLSACategory),  
EjhJobEffDate  
  
FROM dbo.EmpHJob  
WHERE @Fields = '' OR @Fields LIKE '%EjhFLSACategory%'  
  
  
-----------  
-- Delete any rows where value didn't change  
-----------  
  
DELETE FROM @tblResult  
WHERE COALESCE(OldValue, '') = COALESCE(NewValue, '')  
  
  
-----------  
-- Reduce to the last effective-dated change  
-----------  
  
DELETE FROM @tblResult  
  FROM @tblResult a  
WHERE RowID <> (SELECT MAX(RowID) FROM @tblResult b  
                  WHERE b.COID = a.COID  
                    AND b.EEID = a.EEID  
          AND b.FieldName = a.FieldName)  
  
  
RETURN  
  
  
END  
  
