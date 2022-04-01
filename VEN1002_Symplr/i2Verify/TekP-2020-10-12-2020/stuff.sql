select * from dbo.U_EI2VRPAYEX_drvTbl
--where drvNameLast IN ('Landkamer','Lyons','Stalsworth','Borsella','Ausberger')
where drvEEID IN ('CCIZPS0000K0') --,'C9FKHM0000K0','C61FXY0000K0','CEBHZB0000K0','CL4G70000030')
order by drvEEID



SELECT A.PthEEID AS aPthEEID, A.PthCOID AS aPthCOID, A.PthTaxCode AS aPthTaxCode, PthCurTaxAmt, PthPerControl, A.*
			FROM dbo.pTaxHist A WITH (NOLOCK)
			WHERE PthTypeOfTax = 'SIT'
				AND A.PthCurTaxAmt > 0
				AND A.PthPerControl BETWEEN '202011201' AND '202011209'
				AND A.PthEEID = 'CCIZPS0000K0'



--select * from dbo.vw_int_PEarHist WITH (NOLOCK) where PehEEID = 'CCIZPS0000K0' AND pehPerControl BETWEEN '202011201' AND '202011209'