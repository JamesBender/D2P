/* 
1.	Install the code for the EEQFX custom window & interface:
-	Copy/Paste & execute the current “Equifax EEQFX All Install YYYYMMDD.txt” script on client DB

2.	Deploy the custom Equifax configuration window package:
-	From the client environment, Right click the windows ‘Start’ button, select ‘Run’ and Open:  Custpack.exe
-	Select ‘Deploy Package’ – click Next
-	Select the Package File (EEQFX.czp) from the local path of the current TALX zip file extracted
-	Click Next & close when successful install message is displayed.

3.	Update File Paths (UD Files):

-- Update File Paths:
update dbo.u_dsi_configuration
set CfgValue = '\\us.saas\EW4\EW44\Downloads\V10\Exports\NSMIN\EmployeeHistoryExport\'
where FormatCode = 'EEQFX'
and CfgName in ('ExportPath','OnDemandPath','TestPath')


--paste results from these queries in the ‘Mapping Worksheet’ provided to the client for mapping:

select ernearncode,ernlongdesc
from earncode with(nolock)
where erncountrycode = 'USA'

select tchCode,tchDesc
from trmreasn with(nolock)

----------------------------------------------------------------------
-- Defined Translations:

select * 
from dbo.u_dsi_translations_v2
where FormatCode IN ('EEQFX','ETALX')

----------------------------------------------------------------------
-- Defined Configuration: --

select *
from dbo.u_dsi_configuration
where FormatCode IN ('EEQFX','ETALX')


----------------------------------------------------------------------
-- Update the EarnCodes & TermReasons from the MAPPED Worksheet

/* for Mapping Worksheet - XLS:
EEQFX (EarnCodes import):

="INSERT INTO dbo.u_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) VALUES ('EEQFX', 'tEarncode','"&TRIM(A7)&"', '"&LEFT(C7,1)&"');"

EEQFX (TermReasons import):

="INSERT INTO dbo.u_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) VALUES ('EEQFX', 'tUCXTermReason','"&TRIM(A5)&"', '"&TRIM(C5)&"');"
*/

----------------------------------------------------------------------
-- ADD Earn Codes:

select * 
from dbo.u_dsi_translations_v2
where FormatCode = 'EEQFX'
and TransCode = 'tEarncode'

/*
delete dbo.u_dsi_translations_v2
where FormatCode = 'EEQFX'
and TransCode = 'tEarncode'


INSERT from XLS HERE:



*/


----------------------------------------------------------------------
-- ADD Term Reason Codes:

select * 
from dbo.u_dsi_translations_v2
where FormatCode = 'EEQFX'
and TransCode = 'tUCXTermReason'

/*
delete dbo.u_dsi_translations_v2
where FormatCode = 'EEQFX'
and TransCode = 'tUCXTermReason'


INSERT from XLS HERE:



*/

/* -- Make EEQFX interface available on .NET --

Begin Tran
Insert into CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate)
Select GetDate(),adhengine,adhFormatCode,1,GetDate() from AscDefH where adhengine = 'EmpExport' 
and AdhFormatCode = 'EEQFX'
commit

select * from CustomTemplates

*/

