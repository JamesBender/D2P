select * from dbo.U_ESPBPAYEXP_drvTbl;

select * from dbo.U_dsi_BDM_ESPBPAYEXP WITH (NOLOCK)

select top 10 * from EmpDed Where EedDedCode IN ('FTEE','PTEE','PT401','TEMPE')