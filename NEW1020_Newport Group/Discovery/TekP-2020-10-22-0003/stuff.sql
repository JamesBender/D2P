--select * from dbo.U_EDSICCBEXP_drvTbl_QB;

--select * from dbo.U_EDSICCBEXP_drvTbl_QBEVENT;

--select * from dbo.U_EDSICCBEXP_drvTbl_QBPLANINITIAL;

--select * from dbo.U_EDSICCBEXP_drvTbl_QBDEPENDENT;

--select * from dbo.U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL

select * from dbo.U_EDSICCBEXP_drvTbl_NPM



--select * from dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK) where BdmRunId = 'QB' AND BdmDedCode IN ('FSA','FSALP')


/*Select * from (
SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
					JOIN dbo.U_EDSICCBEXP_drvTbl_QB ON drvEEID = EdhEEID
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DENBA','DENAD','UMHDH','UMPPO','VIS','MHMO','KHDHP','FSA','FSALP','STDE') 
                        AND edhChangeReason IN ('201','204','210','LEVNT3','LEVNT4','200')
						AND BchIsCobraQualifiedEvent  = 'Y') AS X where RN = 1*/

/*select edhChangeReason, EdhDedCode, EdhEffDate, * from EmpHDed where edhChangeReason IN ('201','204','210','LEVNT3','LEVNT4') and EdhDedCode IN ('DENBA','DENAD','UMHDH','UMPPO','VIS','MHMO','KHDHP','FSA','FSALP','STDE') */

--select top 10 * from EmpDed

