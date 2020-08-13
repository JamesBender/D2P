Begin Tran

DECLARE @Idx INT = 2;
DECLARE @Field INT = 292;

WHILE @Idx < 41
BEGIN

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep First Name ' + CAST(@Idx as VARCHAR(2)) + ' "' , CAST(@Field AS VARCHAR(3)),'(''DA''=''T,'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep First Name ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep Last Name  ' + CAST(@Idx as VARCHAR(2)) + ' "' ,CAST(@Field AS VARCHAR(3)),'(''DA''=''T,'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep Last Name ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep M I  ' + CAST(@Idx as VARCHAR(2)) + ' "',CAST(@Field AS VARCHAR(3)),'(''DA''=''T,'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep M I  ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep Gender ' + CAST(@Idx as VARCHAR(2)) + ' "',CAST(@Field AS VARCHAR(3)),'(''DA''=''T,'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep Gender ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep DOB ' + CAST(@Idx as VARCHAR(2)) + ' "',CAST(@Field AS VARCHAR(3)),'(''DA''=''T,'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep DOB ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep Relationship Code ' + CAST(@Idx as VARCHAR(2)) + ' "',CAST(@Field AS VARCHAR(3)),'(''DA''=''T,'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep Relationship Code ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep Student Code ' + CAST(@Idx as VARCHAR(2)) + ' "',CAST(@Field AS VARCHAR(3)),'(''DA''=''T,'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep Student Code ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep Disabled YN ' + CAST(@Idx as VARCHAR(2)) + ' "',CAST(@Field AS VARCHAR(3)),'(''DA''=''T,'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep Disabled YN ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep Cvg Indicator ' + CAST(@Idx as VARCHAR(2)) + ' "',CAST(@Field AS VARCHAR(3)),'(''DA''=''T,'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep Cvg Indicator ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Field = @Field + 1

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) 
VALUES ('"Dep DHMO PCP  ' + CAST(@Idx as VARCHAR(2)) + ' "',CAST(@Field AS VARCHAR(3)),'(''DA''=''T'')','ELINFINEXPZ0','50','H','02',CAST(@Field AS VARCHAR(3)),NULL,'Dep DHMO PCP  ' + CAST(@Idx as VARCHAR(2)),NULL,NULL);

SET @Idx = @Idx + 1
END
