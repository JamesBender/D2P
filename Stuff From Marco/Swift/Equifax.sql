Select * from U_EEQFX_tEarnCode where Srcvalue = 'DMIMP'

Begin tran
Update U_dsi_translations_v2 set TransValue = 'X' where TransCode = 'tEarnCode' and SrcValue IN('DMIMP') and FormatCode = 'EEQFX'
Update U_dsi_translations_v2 set TransValue = 'H' where TransCode = 'tEarnCode' and SrcValue IN('FLOAT','HOL') and FormatCode = 'EEQFX'
Update U_dsi_translations_v2 set TransValue = 'V' where TransCode = 'tEarnCode' and SrcValue IN('VAC') and FormatCode = 'EEQFX'

Select * from U_dsi_translations_v2  where TransCode = 'tEarnCode' and SrcValue IN('FLOAT','VAC','HOL') and FormatCode = 'EEQFX'
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','CBCOM','C')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','CSCOM','C')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','MAT','S')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','MEAL','M')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','MEALS','M')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','MPDE','M')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','NQSO','M')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','PTOPT','V')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','REFB','B')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','NS3E','R')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','NS3HW','O')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','NS3OT','O')
Insert into U_dsi_translations_v2 (FormatCode,TransCode,SrcValue,TransValue) values('EEQFX','tEarnCode','CBON','B')
Select * from U_dsi_translations_v2  where TransCode = 'tEarnCode' and SrcValue IN('CBCOM','CSCOM','MAT','MEALS','MPDE','NQSO','PTOPT','REFB','NS3E','NS3HW','NS3OT','CBON') and FormatCode = 'EEQFX'
commit
Rollback

TFBEN
OTC