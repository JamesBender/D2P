 CREATE FUNCTION [dbo].[fn_AddDoubleQuotes] (@InputString VARCHAR(MAX))  
RETURNS VARCHAR(8000)  
WITH EXECUTE AS CALLER  
AS  
  
/************************************************************  
  
Created By: Ethan Lee  
Create Date: 06/13/2014  
  
Purpose: Wrap string in double quotes if the string contains a comma.  
  
Command: PRINT dbo.fn_AddDoubleQuotes('He,llo')  
  
Revision History  
----------------  
Update By         Date          CP Num         Descr  
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx  
  
************************************************************/  
  
BEGIN  
  
 IF CHARINDEX(',',@InputString) > 0 RETURN '"' + @InputString + '"'  
   
 RETURN @InputString  
   
END  
  
  