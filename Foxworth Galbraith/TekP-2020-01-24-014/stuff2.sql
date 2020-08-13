select * from dbo.U_EDISCCOBQB_drvTbl_QB WITH (NOLOCK) where drvEEID = '8QSL7J0000Y0'

--select * from Contacts where ConEEID = '8QSL7J0000Y0'

select * from dbo.U_EDISCCOBQB_drvTbl_QBEVENT with (nolock) where drvEventType like '%*%'

--select * from dbo.U_EDISCCOBQB_drvTbl_QBPLANINITIAL with (nolock)

select * from dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENT with (nolock) where drvEEID = '8QSL7J0000Y0'

--select * from dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL with (nolock)

--select * from dbo.U_EDISCCOBQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL with (nolock)

--select * from dbo.U_EDISCCOBQB_drvTbl_NPM with (nolock)