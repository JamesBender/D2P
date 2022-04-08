--sp_getEEID 'Shelton' -- CQSGF3001040
--sp_getEEID 'Murray' -- CQSGL0000040

--DECLARE @EEID VARCHAR(12) = 'CQSGF3001040'
DECLARE @EEID VARCHAR(12) = 'CQSGL0000040'

--select * from dbo.U_EPENCERTAX_drvTbl where drvEEID = @EEID

/*
select PthTaxCode, PthCurTaxAmt, pehEarncode, *
FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PehGenNumber = PthGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT('202203311',4)
    AND pehEarncode in ('BEREV','FLOAT','GTL','HOL','HOLW','JURY','PTO','REG','RETRO','STD','SICK')
	AND pehEEID = @EEID
	AND PthTaxCode = 'USMEDEE'
	AND PehPerControl <= '202203311'
	;


select PthTaxCode, PthCurTaxAmt, pehEarncode, *
FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PehGenNumber = PthGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT('202203311',4)
    AND pehEarncode not in ('BEREV','FLOAT','GTL','HOL','HOLW','JURY','PTO','REG','RETRO','STD','SICK')
	AND pehEEID = @EEID
	AND PthTaxCode = 'USMEDEE'
	AND PehPerControl <= '202203311'
*/


-- 418.34
SELECT DISTINCT
		PthMedicareYTD        = SUM(CASE WHEN PthTaxCode = 'USMEDEE' THEN PthCurTaxAmt ELSE 0.00 END)
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PehGenNumber = PthGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT('202203311',4)
    AND pehEarncode in ('BEREV','FLOAT','GTL','HOL','HOLW','JURY','PTO','REG','RETRO','STD','SICK')
	AND pehEEID = @EEID
    AND PehPerControl <= '202203311'
    GROUP BY PehEEID,PehCOID


	SELECT DISTINCT
		PthMedicareYTD        = SUM(CASE WHEN PthTaxCode = 'USMEDEE' THEN PthCurTaxAmt ELSE 0.00 END)
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PehGenNumber = PthGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT('202203311',4)
    AND pehEarncode not in ('BEREV','FLOAT','GTL','HOL','HOLW','JURY','PTO','REG','RETRO','STD','SICK')
	AND pehEEID = @EEID
    AND PehPerControl <= '202203311'
    GROUP BY PehEEID,PehCOID
