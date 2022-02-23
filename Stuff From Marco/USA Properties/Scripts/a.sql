Select eedeeid as bdmeeid,
	  eedcoid as bdmcoid,
      NULL as bdmrecid,
	  'EMP' as bdmrectype,
	  'EMP' as bdmrelationship,
	  EedBenAmt as bdmbenamt,
      eeddedcode as bdmdedcode,
      eedbenstartdate as bdmbenstartdate,
      eedbenstopdate as bdmbenstopdate
    FROM dbo.U_DSI_BDM_EmpDeductions where eedFormatCode = 'ESTAFFCUEX'
UNION ALL
Select dbneeid as bdmeeid,
	  eedcoid as bdmcoid,
      dbnSystemId as bdmrecid,
	  'DEP' as bdmrectype,
	  dbnRelationship as bdmrelationship,
	  dedeebenamt as bdmbenamt,
      dbndedcode as bdmdedcode,
      dbnbenstartdate as bdmbenstartdate,
      dbnbenstopdate as bdmbenstopdate
    FROM dbo.U_DSI_BDM_DepDeductions where dbnFormatCode = 'ESTAFFCUEX'

