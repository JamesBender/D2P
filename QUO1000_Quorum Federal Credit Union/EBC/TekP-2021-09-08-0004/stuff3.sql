--sp_getEEID 'Sementilli' -- 9U6ZSX0030K0
--sp_getEEID 'Boyette' -- 9U6ZWB0000K0

--DECLARE @EEID VARCHAR(12) = '9U6ZSX0030K0' -- Semmentilli
DECLARE @EEID VARCHAR(12) = '9U6ZWB0000K0'

--SELECT * from dbo.U_EEBCCOBEXP_drvTbl_QB
--WHERE drvEEID = @EEID

SELECT * from dbo.U_EEBCCOBEXP_drvTbl_QBEVENT
WHERE drvEEID = @EEID

--select * from dbo.U_EEBCCOBEXP_drvTbl_QBPLANINITIAL
--WHERE drvEEID = @EEID

select * from dbo.U_dsi_BDM_EEBCCOBEXP WITH (NOLOCK)
where BdmEEID = @EEID
AND BdmDedCode IN ('DENBK','DENL','DENG','DENKG','DEN','DENK1')
order by BdmDepRecID

select DbnDedCode, DbnBenStatus, DbnDepRecID, DbnRelationship, DbnBenStopDate, * 
from dbo.U_dsi_BDM_DepDeductions 
            WHERE  dbneeid = @EEID
            AND dbnformatcode = 'EEBCCOBEXP'
			AND DbnDedCode IN ('DENBK','DENL','DENG','DENKG','DEN','DENK1')