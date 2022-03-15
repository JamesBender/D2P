select drvLtdPlanSummary, drvLtdEmpGroupId, drvSort,  drvSSN, drvEmployeeID, drvNameLast, drvNameFirst from dbo.U_EHARTTDFML_drvTbl

/*
f eeddedcode = LTDER and eecannsalary > 70000.00 send 1B1 
if eeddedcode = LTDER and eecannsalary < 70000.00 send 1B2
if eeddedcode = LTDBU send 2B1

if eeddedcode = LTDER send 5
if eeddedcode = LTDBU send 7

*/

