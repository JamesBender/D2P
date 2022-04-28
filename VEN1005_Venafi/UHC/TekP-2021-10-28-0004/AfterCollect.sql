CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EVENCOBDEP]
AS

/************************************************************

Client: Venafi

Created By: James Bender
Business Analyst: Lea King
Create Date: 4/27/2022
ChangePoint Request Number: TekP-2021-10-28-0004

Purpose: Adjusting record lengths (the vendor wants each record type to have a differen length)

Revision History
----------------
Update By         Date          CP Num         Descr
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx

************************************************************/

-----------
-- If testing, insert testing header
-----------

IF dbo.dsi_fnVariable('EVENCOBDEP','Testing') = 'Y' BEGIN

    INSERT INTO dbo.U_EVENCOBDEP_File VALUES ('H00','0','1','','','TESTEDT' + SPACE(73))

END
GO