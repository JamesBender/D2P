    LEFT JOIN dbo.U_dsi_BDM_ENUEDDFSAX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
		AND bdmRecType = 'EMP'
    JOIN dbo.U_ENUEDDFSAX_PEarHist WITH (NOLOCK)
        ON PEHEEID = XEEID
    JOIN dbo.U_ENUEDDFSAX_PDedHist WITH (NOLOCK)
      ON PDHEEID = XEEID
	--JOIN dbo.pDedHist WITH (NOLOCK)
     --WHERE bdmRecType = 'EMP'
    ;