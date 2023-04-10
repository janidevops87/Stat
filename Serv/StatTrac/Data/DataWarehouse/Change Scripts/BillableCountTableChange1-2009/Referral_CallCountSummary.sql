/*
   Wednesday, January 28, 2009 11:56:12 AM
   User: 
   Server: ST-DTDEVSVR
   Database: _ReferralDev_DataWarehouse
   Application: MS SQLEM - Data Tools
*/

BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_Referral_CallCountSummary
	(
	YearID int NULL,
	MonthID int NULL,
	DayID int NULL,
	OrganizationID int NULL,
	SourceCodeID int NULL,
	UnknownOTE int NULL,
	UnknownTissue int NULL,
	UnknownTE int NULL,
	UnknownEye int NULL,
	UnknownAgeRO int NULL,
	UnknownMedRO int NULL,
	UnknownOther int NULL,
	UnknownOtherEye int NULL,
	ConsentedOTE int NULL,
	ConsentedTissue int NULL,
	ConsentedTE int NULL,
	ConsentedEye int NULL,
	ConsentedAgeRO int NULL,
	ConsentedMedRO int NULL,
	ConsentedOther int NULL,
	ConsentedOtherEye int NULL,
	DeniedOTE int NULL,
	DeniedTissue int NULL,
	DeniedTE int NULL,
	DeniedEye int NULL,
	DeniedAgeRO int NULL,
	DeniedMedRO int NULL,
	DeniedOther int NULL,
	DeniedOtherEye int NULL,
	NotApprchOTE int NULL,
	NotApprchTissue int NULL,
	NotApprchTE int NULL,
	NotApprchEye int NULL,
	NotApprchAgeRO int NULL,
	NotApprchMedRO int NULL,
	NotApprchOther int NULL,
	NotApprchOtherEye int NULL,
	TotOTE int NULL,
	TotTissue int NULL,
	TotTE int NULL,
	TotEye int NULL,
	TotAgeRO int NULL,
	TotMedRO int NULL,
	TotOther int NULL,
	TotOtherEye int NULL,
	TotRO int NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.Referral_CallCountSummary)
	 EXEC('INSERT INTO dbo.Tmp_Referral_CallCountSummary (YearID, MonthID, DayID, OrganizationID, SourceCodeID, UnknownOTE, UnknownTissue, UnknownTE, UnknownEye, UnknownAgeRO, UnknownMedRO, UnknownOther, UnknownOtherEye, ConsentedOTE, ConsentedTissue, ConsentedTE, ConsentedEye, ConsentedAgeRO, ConsentedMedRO, ConsentedOther, ConsentedOtherEye, DeniedOTE, DeniedTissue, DeniedTE, DeniedEye, DeniedAgeRO, DeniedMedRO, DeniedOther, DeniedOtherEye, NotApprchOTE, NotApprchTissue, NotApprchTE, NotApprchEye, NotApprchAgeRO, NotApprchMedRO, NotApprchOther, NotApprchOtherEye, TotOTE, TotTissue, TotTE, TotEye, TotAgeRO, TotMedRO, TotOther, TotOtherEye, TotRO)
		SELECT YearID, MonthID, DayID, OrganizationID, SourceCodeID, CONVERT(int, UnknownOTE), CONVERT(int, UnknownTissue), CONVERT(int, UnknownTE), CONVERT(int, UnknownEye), CONVERT(int, UnknownAgeRO), CONVERT(int, UnknownMedRO), CONVERT(int, UnknownOther), CONVERT(int, UnknownOtherEye), CONVERT(int, ConsentedOTE), CONVERT(int, ConsentedTissue), CONVERT(int, ConsentedTE), CONVERT(int, ConsentedEye), CONVERT(int, ConsentedAgeRO), CONVERT(int, ConsentedMedRO), CONVERT(int, ConsentedOther), CONVERT(int, ConsentedOtherEye), CONVERT(int, DeniedOTE), CONVERT(int, DeniedTissue), CONVERT(int, DeniedTE), CONVERT(int, DeniedEye), CONVERT(int, DeniedAgeRO), CONVERT(int, DeniedMedRO), CONVERT(int, DeniedOther), CONVERT(int, DeniedOtherEye), CONVERT(int, NotApprchOTE), CONVERT(int, NotApprchTissue), CONVERT(int, NotApprchTE), CONVERT(int, NotApprchEye), CONVERT(int, NotApprchAgeRO), CONVERT(int, NotApprchMedRO), CONVERT(int, NotApprchOther), CONVERT(int, NotApprchOtherEye), TotOTE, TotTissue, TotTE, TotEye, TotAgeRO, TotMedRO, TotOther, TotOtherEye, TotRO FROM dbo.Referral_CallCountSummary TABLOCKX')
GO
DROP TABLE dbo.Referral_CallCountSummary
GO
EXECUTE sp_rename N'dbo.Tmp_Referral_CallCountSummary', N'Referral_CallCountSummary', 'OBJECT'
GO
COMMIT
