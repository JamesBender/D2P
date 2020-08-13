Begin Tran

DECLARE @Idx INT = 2;
DECLARE @Field INT = 292;

WHILE @Idx < 41
BEGIN

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDepFirstName' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UA''=''T,'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep First Name ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDepLastName' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UA''=''T,'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep Last Name ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDepMiddleInitial' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UA''=''T,'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep M I  ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDepGender' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UA''=''T,'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep Gender ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDepDateOfBirth' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep DOB ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDepRelationshipCode' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UA''=''T,'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep Relationship Code ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDepStudentCode' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UA''=''T,'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep Student Code ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDepDisabledYN' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UA''=''T,'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep Disabled YN ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDepCvgIndicator' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UA''=''T,'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep Cvg Indicator ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"drvDedDhmoPcp' + CAST(@Idx as VARCHAR(2)) + '"',CAST(@Field AS VARCHAR(3)),'(''UA''=''T'')','ELINFINEXPZ0','50','D','10',CAST(@Field AS VARCHAR(3)),NULL,'Dep DHMO PCP  ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Idx = @Idx + 1
END


SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINFINEXP%'
	and AdfRecType = 'D' 
	--and AdfSetNumber = '02'
	 and AdfFieldNumber > 280
ORDER BY AdfSetNumber, AdfFieldNumber;

