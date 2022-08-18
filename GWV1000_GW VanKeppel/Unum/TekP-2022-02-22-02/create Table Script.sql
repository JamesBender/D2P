USE [ULTIPRO_WPGWK]
GO

/****** Object:  Table [dbo].[U_EGWVKUNUMH_drvTbl]    Script Date: 7/8/2022 4:05:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[U_EGWVKUNUMH_drvTbl](
	[drvEEID] [char](12) NULL,
	[drvCoID] [char](5) NULL,
	[drvDepRecID] [varchar](12) NULL,
	[drvSort] [char](12) NOT NULL,
	[drvSubSort] [char](12) NOT NULL,
	[drvEnroll2] [varchar](4) NOT NULL,
	[drvPolicy] [varchar](6) NULL,
	[drvMemberID] [char](11) NULL,
	[drvDOH] [varchar](10) NULL,
	[drvSalary] [money] NULL,
	[drvHours] [varchar](1) NOT NULL,
	[drvTermDate] [varchar](10) NULL,
	[drvTermReason] [varchar](2) NULL,
	[drvNewMemberId] [char](11) NULL,
	[drvFirstName] [varchar](100) NULL,
	[drvMiddeName] [varchar](50) NULL,
	[drvLastName] [varchar](100) NULL,
	[drvSuffix] [varchar](30) NULL,
	[drvEepGender] [char](1) NULL,
	[drvEepDateOfBirth] [varchar](10) NULL,
	[drvEepAddressEmail] [varchar](50) NULL,
	[drvConNameFirst] [varchar](100) NULL,
	[drvConGender] [char](1) NULL,
	[drvConDateOfBirth] [varchar](10) NULL,
	[drvClass] [varchar](4) NULL,
	[drvEffectiveDate] [varchar](10) NULL,
	[drvSpouseCoverage] [varchar](1) NOT NULL,
	[drvChildCoverage] [varchar](1) NOT NULL,
	[drvSignatureDate] [varchar](10) NULL,
	[drvAddType] [varchar](1) NOT NULL,
	[drvBenefitId1] [varchar](2) NOT NULL,
	[drvPlanCode1] [varchar](6) NOT NULL,
	[drvBenefitQualifyingDate1] [varchar](10) NULL,
	[drvBenefitTermDate1] [varchar](10) NULL,
	[drvBenefitSelectionAmount1] [numeric](19, 4) NULL,
	[drvBenefitId2] [varchar](2) NOT NULL,
	[drvPlanCode2] [varchar](6) NOT NULL,
	[drvBenefitQualifyingDate2] [varchar](10) NULL,
	[drvBenefitTermDate2] [varchar](10) NULL,
	[drvBenefitSelectionAmount2] [numeric](19, 4) NULL,
	[drvBenefitId3] [varchar](2) NOT NULL,
	[drvPlanCode3] [varchar](6) NOT NULL,
	[drvBenefitQualifyingDate3] [varchar](10) NULL,
	[drvBenefitTermDate3] [varchar](10) NULL,
	[drvBenefitSelectionAmount3] [numeric](19, 4) NULL,
	[drvBenefitId4] [varchar](2) NOT NULL,
	[drvPlanCode4] [varchar](6) NOT NULL,
	[drvBenefitQualifyingDate4] [varchar](10) NULL,
	[drvBenefitTermDate4] [varchar](10) NULL,
	[drvBenefitSelectionAmount4] [numeric](19, 4) NULL,
	[drvBenefitId5] [varchar](2) NOT NULL,
	[drvPlanCode5] [varchar](6) NOT NULL,
	[drvBenefitQualifyingDate5] [varchar](10) NULL,
	[drvBenefitTermDate5] [varchar](10) NULL,
	[drvBenefitSelectionAmount5] [numeric](19, 4) NULL,
	[drvBenefitId6] [varchar](2) NOT NULL,
	[drvPlanCode6] [varchar](6) NOT NULL,
	[drvBenefitQualifyingDate6] [varchar](10) NULL,
	[drvBenefitTermDate6] [varchar](10) NULL,
	[drvBenefitSelectionAmount6] [numeric](19, 4) NULL
) ON [PRIMARY]
GO


