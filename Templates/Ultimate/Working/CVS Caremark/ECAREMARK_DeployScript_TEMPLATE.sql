SET NOCOUNT ON;
/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\CVSCaremark\)
@FileOEPath - Replace with the OE Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\CVSCaremark\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\CVSCaremark\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)
@FileCustomerName - Replace with the file name for the client

--Data Parameters
@MinimumCoverageDate - Replace with the minimum coverage date in the spec. 
@DedList - Replace with the deduction list in the spec
@CarrierNum - Replace with the Carrier Number from the Spec
@CarrierName - Replace with Carrier Name from the spec
@Account - Replace with the Account information from the Spec (NOTE: This will likely be a case statement)
@Group - Replace with the Group information from the Spec (NOTE: This will likely be a case statement)

Go thru the driver table code to update fields pertaining to your client
*/

IF OBJECT_ID('dsi_vwECAREMARK_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECAREMARK_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECAREMARK') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECAREMARK];
GO
IF OBJECT_ID('U_ECAREMARK_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECAREMARK_Trailer];
GO
IF OBJECT_ID('U_ECAREMARK_Members') IS NOT NULL DROP TABLE [dbo].[U_ECAREMARK_Members];
GO
IF OBJECT_ID('U_ECAREMARK_Header') IS NOT NULL DROP TABLE [dbo].[U_ECAREMARK_Header];
GO
IF OBJECT_ID('U_ECAREMARK_File') IS NOT NULL DROP TABLE [dbo].[U_ECAREMARK_File];
GO
IF OBJECT_ID('U_ECAREMARK_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECAREMARK_EEList];
GO
IF OBJECT_ID('U_ECAREMARK_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECAREMARK_drvTbl];
GO
IF OBJECT_ID('U_ECAREMARK_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECAREMARK_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECAREMARK') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECAREMARK];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECAREMARK';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECAREMARK';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECAREMARK';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECAREMARK';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECAREMARK';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECAREMARK','CVS RX Caremark Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1400','S','N','ECAREMARK0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','ECAREMARK0Z0','1','D','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrier"','2','(''UA''=''F'')','ECAREMARK0Z0','9','D','01','2',NULL,'Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierName"','3','(''UA''=''F'')','ECAREMARK0Z0','25','D','01','11',NULL,'Carrier Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompAddress1"','4','(''UA''=''F'')','ECAREMARK0Z0','25','D','01','36',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompAddress2"','5','(''UA''=''F'')','ECAREMARK0Z0','15','D','01','61',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompCity"','6','(''UA''=''F'')','ECAREMARK0Z0','20','D','01','76',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompState"','7','(''UA''=''F'')','ECAREMARK0Z0','2','D','01','96',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompZip"','8','(''UA''=''F'')','ECAREMARK0Z0','10','D','01','98',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompPhone"','9','(''UA''=''F'')','ECAREMARK0Z0','10','D','01','108',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreationDate"','10','(''UA''=''F'')','ECAREMARK0Z0','7','D','01','118',NULL,'Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','ECAREMARK0Z0','1275','D','01','125',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*"','12','(''DA''=''F'')','ECAREMARK0Z0','1','D','01','1400',NULL,'EOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','ECAREMARK0Z0','1','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrier"','2','(''UA''=''F'')','ECAREMARK0Z0','9','D','10','2',NULL,'Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccount"','3','(''UA''=''F'')','ECAREMARK0Z0','15','D','10','11',NULL,'Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroup"','4','(''UA''=''F'')','ECAREMARK0Z0','15','D','10','26',NULL,'Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberID"','5','(''UA''=''F'')','ECAREMARK0Z0','18','D','10','41',NULL,'Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','ECAREMARK0Z0','3','D','10','59',NULL,'Person Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','7','(''UA''=''F'')','ECAREMARK0Z0','1','D','10','62',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','8','(''UA''=''F'')','ECAREMARK0Z0','25','D','10','63',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','9','(''UA''=''F'')','ECAREMARK0Z0','15','D','10','88',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','10','(''UA''=''F'')','ECAREMARK0Z0','1','D','10','103',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','11','(''UA''=''F'')','ECAREMARK0Z0','1','D','10','104',NULL,'Sex Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','12','(''UD112''=''F'')','ECAREMARK0Z0','8','D','10','105',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','13','(''DA''=''F'')','ECAREMARK0Z0','1','D','10','113',NULL,'Multi Birth Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','114',NULL,'Member Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','15','(''DA''=''F'')','ECAREMARK0Z0','1','D','10','115',NULL,'Language Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','116',NULL,'DUR Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','ECAREMARK0Z0','18','D','10','117',NULL,'DUR Key',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','18','(''UA''=''F'')','ECAREMARK0Z0','9','D','10','135',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','19','(''UA''=''F'')','ECAREMARK0Z0','40','D','10','144',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','20','(''UA''=''F'')','ECAREMARK0Z0','40','D','10','184',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','21','(''UA''=''F'')','ECAREMARK0Z0','20','D','10','224',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','22','(''UA''=''F'')','ECAREMARK0Z0','2','D','10','244',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip1"','23','(''UA''=''F'')','ECAREMARK0Z0','5','D','10','246',NULL,'Zip 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip2"','24','(''UA''=''F'')','ECAREMARK0Z0','4','D','10','251',NULL,'Zip 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''F'')','ECAREMARK0Z0','2','D','10','255',NULL,'Zip 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','26','(''UA''=''F'')','ECAREMARK0Z0','4','D','10','257',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','27','(''UA''=''F'')','ECAREMARK0Z0','10','D','10','261',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyFlag"','28','(''UA''=''F'')','ECAREMARK0Z0','1','D','10','271',NULL,'Family Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyType"','29','(''UA''=''F'')','ECAREMARK0Z0','1','D','10','272',NULL,'Family Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyID"','30','(''UA''=''F'')','ECAREMARK0Z0','18','D','10','273',NULL,'Family ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalEffDate"','31','(''UA''=''F'')','ECAREMARK0Z0','7','D','10','291',NULL,'Original From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','32','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','298',NULL,'Benefit Reset Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','33','(''UA''=''F'')','ECAREMARK0Z0','7','D','10','305',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','34','(''UA''=''F'')','ECAREMARK0Z0','7','D','10','312',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''F'')','ECAREMARK0Z0','10','D','10','319',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','36','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','329',NULL,'Plan Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','37','(''DN0''=''F'')','ECAREMARK0Z0','5','D','10','336',NULL,'Brand',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','38','(''DN0''=''F'')','ECAREMARK0Z0','5','D','10','341',NULL,'Generic',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','39','(''DN0''=''F'')','ECAREMARK0Z0','5','D','10','346',NULL,'Copay 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','40','(''DN0''=''F'')','ECAREMARK0Z0','5','D','10','351',NULL,'Copay 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''F'')','ECAREMARK0Z0','6','D','10','356',NULL,'Client Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''F'')','ECAREMARK0Z0','6','D','10','362',NULL,'Client Rider Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','43','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','368',NULL,'Care From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','44','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','375',NULL,'Care Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''SS''=''F'')','ECAREMARK0Z0','10','D','10','382',NULL,'Care Network',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','46','(''DN0''=''F'')','ECAREMARK0Z0','10','D','10','392',NULL,'Care Network Plan Ovr',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','47','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','402',NULL,'Care Network Plan Frm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''F'')','ECAREMARK0Z0','6','D','10','409',NULL,'Care Facility ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''F'')','ECAREMARK0Z0','10','D','10','415',NULL,'Care Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''F'')','ECAREMARK0Z0','10','D','10','425',NULL,'Physician ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','51','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','435',NULL,'Alt Ins From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','52','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','442',NULL,'Alt Ins Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','449',NULL,'Alt Ins. Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''SS''=''F'')','ECAREMARK0Z0','10','D','10','450',NULL,'Alt Ins. Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''SS''=''F'')','ECAREMARK0Z0','18','D','10','460',NULL,'Alt Ins ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','478',NULL,'New Card Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','479',NULL,'FSA Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','480',NULL,'Grace Period Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','481',NULL,'Grace Period Indicator Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','488',NULL,'MedCoverage Type (non Med D)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','61','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','489',NULL,'Med From Date (non Med D)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''SS''=''F'')','ECAREMARK0Z0','11','D','10','496',NULL,'Medicare HIC (non Med D)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','507',NULL,'Family Type From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','514',NULL,'Family Type Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','521',NULL,'Disenrollment Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''SS''=''F'')','ECAREMARK0Z0','80','D','10','522',NULL,'Filler 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','67','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','602',NULL,'CDD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','68','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','609',NULL,'CDD Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''SS''=''F'')','ECAREMARK0Z0','256','D','10','616',NULL,'CDD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','872',NULL,'Accumulation Family Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','873',NULL,'Override Deductible Prorate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','874',NULL,'Override HSA Prorate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','73','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','875',NULL,'Proration Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''SS''=''F'')','ECAREMARK0Z0','5','D','10','882',NULL,'MOOP LIMIT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','75','(''DN0''=''F'')','ECAREMARK0Z0','7','D','10','887',NULL,'MOOP Eff.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''SS''=''F'')','ECAREMARK0Z0','85','D','10','894',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''SS''=''F'')','ECAREMARK0Z0','20','D','10','979',NULL,'Additional ID (3rd ID)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''SS''=''F'')','ECAREMARK0Z0','2','D','10','999',NULL,'3rd ID Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','1001',NULL,'Medicare Participation Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','1002',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','81','(''DN0''=''F'')','ECAREMARK0Z0','8','D','10','1003',NULL,'Medicare Participation Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''SS''=''F'')','ECAREMARK0Z0','8','D','10','1011',NULL,'Medicare Part D Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','1019',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''SS''=''F'')','ECAREMARK0Z0','18','D','10','1020',NULL,'Crosswalk Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''SS''=''F'')','ECAREMARK0Z0','2','D','10','1038',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','1040',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''SS''=''F'')','ECAREMARK0Z0','12','D','10','1041',NULL,'HIC/Railroad Board Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','88','(''DN0''=''F'')','ECAREMARK0Z0','3','D','10','1053',NULL,'LICS Premium Subsidy Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''SS''=''F'')','ECAREMARK0Z0','5','D','10','1056',NULL,'Contract ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''SS''=''F'')','ECAREMARK0Z0','3','D','10','1061',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''SS''=''F'')','ECAREMARK0Z0','30','D','10','1064',NULL,'Caretaker First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''SS''=''F'')','ECAREMARK0Z0','30','D','10','1094',NULL,'Caretaker Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''SS''=''F'')','ECAREMARK0Z0','30','D','10','1124',NULL,'Caretaker Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''SS''=''F'')','ECAREMARK0Z0','30','D','10','1154',NULL,'Caretaker Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''SS''=''F'')','ECAREMARK0Z0','30','D','10','1184',NULL,'Caretaker City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''SS''=''F'')','ECAREMARK0Z0','2','D','10','1214',NULL,'Caretaker State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''SS''=''F'')','ECAREMARK0Z0','9','D','10','1216',NULL,'Caretaker Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''SS''=''F'')','ECAREMARK0Z0','9','D','10','1225',NULL,'ST-Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''SS''=''F'')','ECAREMARK0Z0','15','D','10','1234',NULL,'ST-Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''SS''=''F'')','ECAREMARK0Z0','15','D','10','1249',NULL,'ST-Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''SS''=''F'')','ECAREMARK0Z0','18','D','10','1264',NULL,'ST-Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','1282',NULL,'ST-Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','1283',NULL,'ST-COB  Coverage Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1284',NULL,'Transition Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1291',NULL,'Transition Period Start Date Inactivate Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1298',NULL,'ESRD From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1305',NULL,'ESRD Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1312',NULL,'Dialysis From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1319',NULL,'Dialysis Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1326',NULL,'Transplant From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1333',NULL,'Transplant Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1340',NULL,'MBR Part B Flag From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1347',NULL,'MBR Part B Flag Thru  Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''SS''=''F'')','ECAREMARK0Z0','1','D','10','1354',NULL,'Member Language Print Format Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1355',NULL,'MBR Hospice From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''SS''=''F'')','ECAREMARK0Z0','7','D','10','1362',NULL,'MBR Hospice Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''SS''=''F'')','ECAREMARK0Z0','11','D','10','1369',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''SS''=''F'')','ECAREMARK0Z0','20','D','10','1380',NULL,'QL Client Supplied  External Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*"','119','(''DA''=''F'')','ECAREMARK0Z0','1','D','10','1400',NULL,'EOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','ECAREMARK0Z0','1','D','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrier"','2','(''UA''=''F'')','ECAREMARK0Z0','9','D','90','2',NULL,'Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalRecords"','3','(''UN0''=''F'')','ECAREMARK0Z0','9','D','90','11',NULL,'Total Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','4','(''DN0''=''F'')','ECAREMARK0Z0','9','D','90','20',NULL,'Total Adds',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','5','(''DN0''=''F'')','ECAREMARK0Z0','9','D','90','29',NULL,'Total Changes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','6','(''DN0''=''F'')','ECAREMARK0Z0','9','D','90','38',NULL,'Total Move History',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','7','(''DN0''=''F'')','ECAREMARK0Z0','9','D','90','47',NULL,'Total Roll Accums',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','8','(''DN0''=''F'')','ECAREMARK0Z0','9','D','90','56',NULL,'Total Replacements',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','ECAREMARK0Z0','1335','D','90','65',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*"','10','(''DA''=''F'')','ECAREMARK0Z0','1','D','90','1400',NULL,'EOR',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201707319','EMPEXPORT','SCHEDULED',NULL,'ECAREMARK',NULL,NULL,NULL,'201707319','Jul 31 2017  2:19PM','Jul 31 2017  2:19PM','201707311',NULL,'','','201707311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201707319','EMPEXPORT','OEPASSIVE',NULL,'ECAREMARK',NULL,NULL,NULL,'201707319','Jul 31 2017  2:19PM','Jul 31 2017  2:19PM','201707311',NULL,'','','201707311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CVS RX Caremark Export','201707319','EMPEXPORT','ONDEMAND','Jul 31 2017  3:55PM','ECAREMARK',NULL,NULL,NULL,'201707319','Jul 31 2017 12:00AM','Dec 30 1899 12:00AM','201707011','1866','','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201707319','EMPEXPORT','OEACTIVE','Jul 31 2017  3:58PM','ECAREMARK',NULL,NULL,NULL,'201707319','Jul 31 2017 12:00AM','Dec 30 1899 12:00AM','201707011','706','','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201708319','EMPEXPORT','TEST','Oct 16 2017  5:13PM','ECAREMARK',NULL,NULL,NULL,'201708319','Aug 31 2017 12:00AM','Dec 30 1899 12:00AM','201708011','1469','','','201708011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','OEPath','V','@FileOEPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','SubSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','UDESPath','C','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAREMARK','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAREMARK','D01','dbo.U_ECAREMARK_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAREMARK','D10','dbo.U_ECAREMARK_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAREMARK','D90','dbo.U_ECAREMARK_Trailer',NULL);
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_ECAREMARK_EEList') IS NULL
CREATE TABLE [dbo].[U_ECAREMARK_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECAREMARK_File') IS NULL
CREATE TABLE [dbo].[U_ECAREMARK_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] char(1400) NULL
);


GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECAREMARK]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Customer: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
ChangePoint Request Number: @SRNumber

Interface Name: @CustomFormatName

Purpose: CVS RX Caremark Export - To provide Caremark with employee data for the purpose of plan administration

Revision History
----------------
Update By           Date           Request Num            Desc

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECAREMARK';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECAREMARK';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECAREMARK';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECAREMARK';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECAREMARK' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECAREMARK', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECAREMARK', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECAREMARK', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECAREMARK', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECAREMARK', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECAREMARK';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECAREMARK', @AllObjects = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)
            ,@MinCoverageDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ECAREMARK';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --Set Min coverage Date
    SET @MinCoverageDate = '@MinimumCoverageDate';

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECAREMARK_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECAREMARK_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','@DedList');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStartDateDays','60');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --======================================================================
    -- Getting list of Employees and Contacts
    -- Who enrolled in one or more deductions listed in BDM deduction list
    --======================================================================

    IF object_id('U_ECAREMARK_Members') IS NOT NULL
      DROP TABLE dbo.U_ECAREMARK_Members;

    SELECT 
     memEEID     = xEEID
    ,memDepRecID = ConSystemID
    INTO dbo.U_ECAREMARK_Members
    FROM dbo.U_ECAREMARK_EEList WITH (NOLOCK)
    INNER JOIN dbo.Contacts WITH (NOLOCK) ON xEEID = ConEEID
    INNER JOIN dbo.u_dsi_bdm_ECAREMARK WITH (NOLOCK) ON BdmEEID = xEEID AND BdmDepRecID = ConSystemID
    WHERE EXISTS (SELECT 1 FROM dbo.u_dsi_bdm_ECAREMARK WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP') --Only include Dependents if corresponding employee record exists
    AND   (BdmBenStopDate IS NULL OR BdmBenStopDate > @MinCoverageDate) --So that coverages terminated before min coverage date are not included

    UNION

    SELECT 
     memEEID     = xEEID
    ,memDepRecID = ''
    FROM dbo.U_ECAREMARK_EEList WITH (NOLOCK)
    INNER JOIN dbo.u_dsi_bdm_ECAREMARK WITH (NOLOCK) ON xEEID = BdmEEID
    WHERE BdmRecType = 'EMP'
    AND   (BdmBenStopDate IS NULL OR BdmBenStopDate > @MinCoverageDate)
     ;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECAREMARK_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECAREMARK_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECAREMARK_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID
        -- standard fields above and additional driver fields below
        ,drvRecordType		= '1'
		,drvCarrier			= '@CarrierNum'
		,drvAccount         = @Account
        ,drvGroup           = @Group
        ,drvMemberID        = EepSSN
        ,drvRelationship    = CASE WHEN ConSystemID IS NULL THEN '1' 
                                 ELSE CASE WHEN ConRelationship = 'SPS' THEN '2' 
                                           ELSE '3'
                                      END
                              END
        ,drvLastName        = CASE WHEN ConSystemID IS NULL THEN  RTRIM(EepNameLast) ELSE  RTRIM(ConNameLast) END
        ,drvFirstName       = CASE WHEN ConSystemID IS NULL THEN  RTRIM(EepNameFirst)ELSE RTRIM(ConNameFirst) END
        ,drvMiddleInitial   = CASE WHEN ConSystemID IS NULL THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvGender          = CASE WHEN ConSystemID IS NULL THEN EepGender ELSE ConGender END
        ,drvDateofBirth     = CASE WHEN ConSystemID IS NULL THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvSSN             = CASE WHEN ConSystemID IS NULL THEN eepSSN ELSE ISNULL(ConSSN,REPLICATE('0',9)) END
        ,drvAddress1        = CASE WHEN ConSystemID IS NULL THEN RTRIM(EepAddressLine1) ELSE RTRIM(ConAddressLine1) END
        ,drvAddress2        = CASE WHEN ConSystemID IS NULL THEN RTRIM(EepAddressLine2) ELSE RTRIM(ConAddressLine2) END
        ,drvCity            = CASE WHEN ConSystemID IS NULL THEN RTRIM(EepAddressCity) ELSE RTRIM(ConAddressCity) END
        ,drvState           = CASE WHEN ConSystemID IS NULL THEN RTRIM(EepAddressState) ELSE RTRIM(ConAddressState) END
        ,drvZip1            = CASE WHEN ConSystemID IS NULL THEN LEFT(EepAddressZipCode,5) ELSE LEFT(ConAddressZipCode,5) END
        ,drvZip2            = CASE WHEN ConSystemID IS NULL THEN SUBSTRING(EepAddressZipCode,7,4) ELSE SUBSTRING(ConAddressZipCode,7,4) END
        ,drvCountry         = CASE WHEN ConSystemID IS NULL THEN RTRIM(EepAddressCountry) ELSE RTRIM(ConAddressCountry) END
        ,drvPhoneNumber     = CASE WHEN ConSystemID IS NULL THEN ISNULL(EepPhoneHomeNumber,EecPhoneBusinessNumber) ELSE ISNULL(ConPhoneHomeNumber,ISNULL(EepPhoneHomeNumber,EecPhoneBusinessNumber)) END
        ,drvFamilyFlag        = CASE WHEN BdmBenOption = 'EF' THEN 'Y' END
        ,drvFamilyType      = CASE WHEN BdmBenOption = 'EO' THEN '2' ELSE '1' END
        ,drvFamilyID        = EepSSN
        ,drvOriginalEffDate = '1'+CONVERT(VARCHAR,dbo.fn_dateMax(BdmBenStartDate,@MinCoverageDate),12)
        ,drvEffectiveDate   = '1'+CONVERT(VARCHAR,dbo.fn_dateMax(BdmBenStartDate,@MinCoverageDate),12)
        ,drvTermDate        = CASE WHEN BdmBenStopDate IS NULL THEN '1391231' ELSE '1'+CONVERT(VARCHAR,BdmBenStopDate,12) END
        ------
        ,drvInitialSort = CASE WHEN ConSystemID IS NULL THEN 'B'+EepSSN
        ,drvSort = CASE WHEN ConSystemID IS NULL THEN 'A' 
                        WHEN ConRelationship = 'SPS' THEN 'B'+ISNULL(ConSSN,'0') 
                        ELSE 'D'+ISNULL(ConSSN,'0') 
                   END
    INTO dbo.U_ECAREMARK_drvTbl
    FROM dbo.U_ECAREMARK_EEList WITH (NOLOCK)
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    INNER JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    INNER JOIN dbo.U_ECAREMARK_Members WITH (NOLOCK)
        ON xEEID = MemEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON xEEID = ConEEID AND memDepRecID = ConSystemID
    INNER JOIN dbo.U_dsi_bdm_ECAREMARK WITH (NOLOCK)
        ON bdmEEID = memEEID 
        AND ISNULL(BdmDepRecID,'') = ISNULL(memDepRecID,'')
    ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECAREMARK_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECAREMARK_Header;
    SELECT DISTINCT
         drvRecordType		= '3'
		,drvCarrier			= '@CarrierNum'
		,drvCarrierName		= '@CarrierName'
		,drvCompAddress1    = CmmAddressLine1
        ,drvCompAddress2    = CmmAddressLine2
        ,drvCompCity        = CmmAddressCity
        ,drvCompState       = CmmAddressState
        ,drvCompZip         = CmmAddressZipCode
        ,drvCompPhone       = CmmPhoneNumber
        ,drvCreationDate    = '1'+CONVERT(VARCHAR,GETDATE(),12)
        ,drvInitialSort        = 'A000000000'
        ,drvSort            = 'A'

    INTO dbo.U_ECAREMARK_Header
    FROM dbo.CompMast WITH (NOLOCK)
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECAREMARK_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECAREMARK_Trailer;
    SELECT DISTINCT
          drvRecordType		= '9'
		 ,drvCarrier		= '@CarrierNum'
		 ,drvTotalRecords   = COUNT(*) + (SELECT COUNT(*) FROM dbo.U_ECAREMARK_drvTbl WHERE drvRelationship = '1')
         ,drvInitialSort    = 'Z999999999'
        ,drvSort            = 'Z'
    INTO dbo.U_ECAREMARK_Trailer
    FROM dbo.U_ECAREMARK_drvTbl
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' OR @ExportCode LIKE '%TEST%' THEN '@FileCustomerName.TST' + REPLACE(CONVERT(VARCHAR(10),GETDATE(),101),'/','') + '.txt'
                                  ELSE '@FileCustomerName.MBR' + REPLACE(CONVERT(VARCHAR(10),GETDATE(),101),'/','') + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECAREMARK_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ECAREMARK_File (NOLOCK)
    ORDER BY InitialSort, Right(RecordSet,2),SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECAREMARK%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201707241'
       ,expStartPerControl     = '201707241'
       ,expLastEndPerControl   = '201707319'
       ,expEndPerControl       = '201707319'
WHERE expFormatCode = 'ECAREMARK';

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECAREMARK';
--now able to switch to I drive or J drive path on the fly without hardcoding:
I: drive:
update U_dsi_configuration
set cfgvalue = dbo.dsi_fnVariable('ECAREMARK','TestPath') 
where FormatCode = 'ECAREMARK'
and cfgname = 'ExportPath'

J: drive:
update U_dsi_configuration
set cfgvalue = dbo.dsi_fnVariable('ECAREMARK','UdesPath') 
where FormatCode = 'ECAREMARK'
and cfgname = 'ExportPath'

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECAREMARK_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ECAREMARK_File (NOLOCK)
    ORDER BY InitialSort, Right(RecordSet,2),SubSort;

