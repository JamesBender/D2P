    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EMOOSVAEXP';
	DECLARE @EEID VARCHAR(12) = 'DNEAQT01DRX0'
    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	select @StartDate, @EndDate;

select audDateTime, audNewValue, *
from dbo.vw_AuditData WITH (NOLOCK) 
JOIN dbo.U_EMOOSVAEXP_AuditFields WITH (NOLOCK) 
				ON audTableName = aTableName
				AND audFieldName = aFieldName
where audKey1Value = 'DNEAQT01DRX0'
AND audAction <> 'DELETE'
AND audDateTime BETWEEN DATEADD(DAY, -30, @StartDate) AND @EndDate

SELECT * FROM EmpDed WHERE EedEEID = @EEID --AND EedDedcode = 'VLIFE'
AND EedBenStatusDate > @StartDate
AND eedBenStatus = 'T'
--AND 

SELECT * FROM dbo.U_dsi_BDM_EMOOSVAEXP WITH (NOLOCK) WHERE BdmEEID = @EEID