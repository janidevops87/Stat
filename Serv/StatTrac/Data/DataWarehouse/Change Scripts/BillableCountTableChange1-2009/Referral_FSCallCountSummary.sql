/*
   Wednesday, January 28, 2009 12:00:20 PM
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
CREATE TABLE dbo.Tmp_Referral_FSCallCountSummary
	(
	YearID int NULL,
	MonthID int NULL,
	DayID int NULL,
	OrganizationID int NULL,
	SourceCodeID int NULL,
	NoSecondaryOTE int NULL,
	NoSecondaryTissue int NULL,
	NoSecondaryTE int NULL,
	NoSecondaryEye int NULL,
	NoSecondaryAgeRO int NULL,
	NoSecondaryMedRO int NULL,
	NoSecondaryOther int NULL,
	NoSecondaryOtherEye int NULL,
	SecondaryOTE int NULL,
	SecondaryTissue int NULL,
	SecondaryTE int NULL,
	SecondaryEye int NULL,
	SecondaryAgeRO int NULL,
	SecondaryMedRO int NULL,
	SecondaryOther int NULL,
	SecondaryOtherEye int NULL,
	SecondaryROTotal int NULL,
	FamilyApproachOTE int NULL,
	FamilyApproachTissue int NULL,
	FamilyApproachTE int NULL,
	FamilyApproachEye int NULL,
	FamilyApproachAgeRO int NULL,
	FamilyApproachMedRO int NULL,
	FamilyApproachOther int NULL,
	FamilyApproachOtherEye int NULL,
	FamilyApproachROTotal int NULL,
	MedSocOTE int NULL,
	MedSocTissue int NULL,
	MedSocTE int NULL,
	MedSocEye int NULL,
	MedSocAgeRO int NULL,
	MedSocMedRO int NULL,
	MedSocOther int NULL,
	MedSocOtherEye int NULL,
	MedSocROTotal int NULL,
	FamilyUnavailableOTE int NULL,
	FamilyUnavailableTissue int NULL,
	FamilyUnavailableTE int NULL,
	FamilyUnavailableEye int NULL,
	FamilyUnavailableAgeRO int NULL,
	FamilyUnavailableMedRO int NULL,
	FamilyUnavailableOther int NULL,
	FamilyUnavailableOtherEye int NULL,
	FamilyUnavailableROTotal int NULL,
	CryolifeFormOTE int NULL,
	CryolifeFormTissue int NULL,
	CryolifeFormTE int NULL,
	CryolifeFormEye int NULL,
	CryolifeFormAgeRO int NULL,
	CryolifeFormMedRO int NULL,
	CryolifeFormOther int NULL,
	CryolifeFormOtherEye int NULL,
	CryolifeFormROTotal int NULL,
	FamilyApproachOTECount int NULL,
	FamilyApproachTissueCount int NULL,
	FamilyApproachTECount int NULL,
	FamilyApproachEyeCount int NULL,
	FamilyApproachAgeROCount int NULL,
	FamilyApproachMedROCount int NULL,
	FamilyApproachOtherCount int NULL,
	FamilyApproachOtherEyeCount int NULL,
	FamilyApproachROCountTotal int NULL,
	MedSocOTECount int NULL,
	MedSocTissueCount int NULL,
	MedSocTECount int NULL,
	MedSocEyeCount int NULL,
	MedSocAgeROCount int NULL,
	MedSocMedROCount int NULL,
	MedSocOtherCount int NULL,
	MedSocOtherEyeCount int NULL,
	MedSocROCountTotal int NULL,
	CryolifeFormOTECount int NULL,
	CryolifeFormTissueCount int NULL,
	CryolifeFormTECount int NULL,
	CryolifeFormEyeCount int NULL,
	CryolifeFormAgeROCount int NULL,
	CryolifeFormMedROCount int NULL,
	CryolifeFormOtherCount int NULL,
	CryolifeFormOtherEyeCount int NULL,
	CryolifeFormROCountTotal int NULL,
	SecondaryApproachOTE int NULL,
	SecondaryApproachTissue int NULL,
	SecondaryApproachTE int NULL,
	SecondaryApproachEye int NULL,
	SecondaryApproachAgeRO int NULL,
	SecondaryApproachMedRO int NULL,
	SecondaryApproachOther int NULL,
	SecondaryApproachOtherEye int NULL,
	SecondaryNoApproachOTE int NULL,
	SecondaryNoApproachTissue int NULL,
	SecondaryNoApproachTE int NULL,
	SecondaryNoApproachEye int NULL,
	SecondaryNoApproachAgeRO int NULL,
	SecondaryNoApproachMedRO int NULL,
	SecondaryNoApproachOther int NULL,
	SecondaryNoApproachOtherEye int NULL,
	NoSecondaryApproachOTE int NULL,
	NoSecondaryApproachTissue int NULL,
	NoSecondaryApproachTE int NULL,
	NoSecondaryApproachEye int NULL,
	NoSecondaryApproachAgeRO int NULL,
	NoSecondaryApproachMedRO int NULL,
	NoSecondaryApproachOther int NULL,
	NoSecondaryApproachOtherEye int NULL,
	FSCaseBillOTE int NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.Referral_FSCallCountSummary)
	 EXEC('INSERT INTO dbo.Tmp_Referral_FSCallCountSummary (YearID, MonthID, DayID, OrganizationID, SourceCodeID, NoSecondaryOTE, NoSecondaryTissue, NoSecondaryTE, NoSecondaryEye, NoSecondaryAgeRO, NoSecondaryMedRO, NoSecondaryOther, NoSecondaryOtherEye, SecondaryOTE, SecondaryTissue, SecondaryTE, SecondaryEye, SecondaryAgeRO, SecondaryMedRO, SecondaryOther, SecondaryOtherEye, SecondaryROTotal, FamilyApproachOTE, FamilyApproachTissue, FamilyApproachTE, FamilyApproachEye, FamilyApproachAgeRO, FamilyApproachMedRO, FamilyApproachOther, FamilyApproachOtherEye, FamilyApproachROTotal, MedSocOTE, MedSocTissue, MedSocTE, MedSocEye, MedSocAgeRO, MedSocMedRO, MedSocOther, MedSocOtherEye, MedSocROTotal, FamilyUnavailableOTE, FamilyUnavailableTissue, FamilyUnavailableTE, FamilyUnavailableEye, FamilyUnavailableAgeRO, FamilyUnavailableMedRO, FamilyUnavailableOther, FamilyUnavailableOtherEye, FamilyUnavailableROTotal, CryolifeFormOTE, CryolifeFormTissue, CryolifeFormTE, CryolifeFormEye, CryolifeFormAgeRO, CryolifeFormMedRO, CryolifeFormOther, CryolifeFormOtherEye, CryolifeFormROTotal, FamilyApproachOTECount, FamilyApproachTissueCount, FamilyApproachTECount, FamilyApproachEyeCount, FamilyApproachAgeROCount, FamilyApproachMedROCount, FamilyApproachOtherCount, FamilyApproachOtherEyeCount, FamilyApproachROCountTotal, MedSocOTECount, MedSocTissueCount, MedSocTECount, MedSocEyeCount, MedSocAgeROCount, MedSocMedROCount, MedSocOtherCount, MedSocOtherEyeCount, MedSocROCountTotal, CryolifeFormOTECount, CryolifeFormTissueCount, CryolifeFormTECount, CryolifeFormEyeCount, CryolifeFormAgeROCount, CryolifeFormMedROCount, CryolifeFormOtherCount, CryolifeFormOtherEyeCount, CryolifeFormROCountTotal, SecondaryApproachOTE, SecondaryApproachTissue, SecondaryApproachTE, SecondaryApproachEye, SecondaryApproachAgeRO, SecondaryApproachMedRO, SecondaryApproachOther, SecondaryApproachOtherEye, SecondaryNoApproachOTE, SecondaryNoApproachTissue, SecondaryNoApproachTE, SecondaryNoApproachEye, SecondaryNoApproachAgeRO, SecondaryNoApproachMedRO, SecondaryNoApproachOther, SecondaryNoApproachOtherEye, NoSecondaryApproachOTE, NoSecondaryApproachTissue, NoSecondaryApproachTE, NoSecondaryApproachEye, NoSecondaryApproachAgeRO, NoSecondaryApproachMedRO, NoSecondaryApproachOther, NoSecondaryApproachOtherEye, FSCaseBillOTE)
		SELECT YearID, MonthID, DayID, OrganizationID, SourceCodeID, CONVERT(int, NoSecondaryOTE), CONVERT(int, NoSecondaryTissue), CONVERT(int, NoSecondaryTE), CONVERT(int, NoSecondaryEye), CONVERT(int, NoSecondaryAgeRO), CONVERT(int, NoSecondaryMedRO), CONVERT(int, NoSecondaryOther), CONVERT(int, NoSecondaryOtherEye), CONVERT(int, SecondaryOTE), CONVERT(int, SecondaryTissue), CONVERT(int, SecondaryTE), CONVERT(int, SecondaryEye), CONVERT(int, SecondaryAgeRO), CONVERT(int, SecondaryMedRO), CONVERT(int, SecondaryOther), CONVERT(int, SecondaryOtherEye), CONVERT(int, SecondaryROTotal), CONVERT(int, FamilyApproachOTE), CONVERT(int, FamilyApproachTissue), CONVERT(int, FamilyApproachTE), CONVERT(int, FamilyApproachEye), CONVERT(int, FamilyApproachAgeRO), CONVERT(int, FamilyApproachMedRO), CONVERT(int, FamilyApproachOther), CONVERT(int, FamilyApproachOtherEye), CONVERT(int, FamilyApproachROTotal), CONVERT(int, MedSocOTE), CONVERT(int, MedSocTissue), CONVERT(int, MedSocTE), CONVERT(int, MedSocEye), CONVERT(int, MedSocAgeRO), CONVERT(int, MedSocMedRO), CONVERT(int, MedSocOther), CONVERT(int, MedSocOtherEye), CONVERT(int, MedSocROTotal), CONVERT(int, FamilyUnavailableOTE), CONVERT(int, FamilyUnavailableTissue), CONVERT(int, FamilyUnavailableTE), CONVERT(int, FamilyUnavailableEye), CONVERT(int, FamilyUnavailableAgeRO), CONVERT(int, FamilyUnavailableMedRO), CONVERT(int, FamilyUnavailableOther), CONVERT(int, FamilyUnavailableOtherEye), CONVERT(int, FamilyUnavailableROTotal), CONVERT(int, CryolifeFormOTE), CONVERT(int, CryolifeFormTissue), CONVERT(int, CryolifeFormTE), CONVERT(int, CryolifeFormEye), CONVERT(int, CryolifeFormAgeRO), CONVERT(int, CryolifeFormMedRO), CONVERT(int, CryolifeFormOther), CONVERT(int, CryolifeFormOtherEye), CONVERT(int, CryolifeFormROTotal), CONVERT(int, FamilyApproachOTECount), CONVERT(int, FamilyApproachTissueCount), CONVERT(int, FamilyApproachTECount), CONVERT(int, FamilyApproachEyeCount), CONVERT(int, FamilyApproachAgeROCount), CONVERT(int, FamilyApproachMedROCount), CONVERT(int, FamilyApproachOtherCount), CONVERT(int, FamilyApproachOtherEyeCount), CONVERT(int, FamilyApproachROCountTotal), CONVERT(int, MedSocOTECount), CONVERT(int, MedSocTissueCount), CONVERT(int, MedSocTECount), CONVERT(int, MedSocEyeCount), CONVERT(int, MedSocAgeROCount), CONVERT(int, MedSocMedROCount), CONVERT(int, MedSocOtherCount), CONVERT(int, MedSocOtherEyeCount), CONVERT(int, MedSocROCountTotal), CONVERT(int, CryolifeFormOTECount), CONVERT(int, CryolifeFormTissueCount), CONVERT(int, CryolifeFormTECount), CONVERT(int, CryolifeFormEyeCount), CONVERT(int, CryolifeFormAgeROCount), CONVERT(int, CryolifeFormMedROCount), CONVERT(int, CryolifeFormOtherCount), CONVERT(int, CryolifeFormOtherEyeCount), CONVERT(int, CryolifeFormROCountTotal), CONVERT(int, SecondaryApproachOTE), CONVERT(int, SecondaryApproachTissue), CONVERT(int, SecondaryApproachTE), CONVERT(int, SecondaryApproachEye), CONVERT(int, SecondaryApproachAgeRO), CONVERT(int, SecondaryApproachMedRO), CONVERT(int, SecondaryApproachOther), CONVERT(int, SecondaryApproachOtherEye), CONVERT(int, SecondaryNoApproachOTE), CONVERT(int, SecondaryNoApproachTissue), CONVERT(int, SecondaryNoApproachTE), CONVERT(int, SecondaryNoApproachEye), CONVERT(int, SecondaryNoApproachAgeRO), CONVERT(int, SecondaryNoApproachMedRO), CONVERT(int, SecondaryNoApproachOther), CONVERT(int, SecondaryNoApproachOtherEye), CONVERT(int, NoSecondaryApproachOTE), CONVERT(int, NoSecondaryApproachTissue), CONVERT(int, NoSecondaryApproachTE), CONVERT(int, NoSecondaryApproachEye), CONVERT(int, NoSecondaryApproachAgeRO), CONVERT(int, NoSecondaryApproachMedRO), CONVERT(int, NoSecondaryApproachOther), CONVERT(int, NoSecondaryApproachOtherEye), CONVERT(int, FSCaseBillOTE) FROM dbo.Referral_FSCallCountSummary TABLOCKX')
GO
DROP TABLE dbo.Referral_FSCallCountSummary
GO
EXECUTE sp_rename N'dbo.Tmp_Referral_FSCallCountSummary', N'Referral_FSCallCountSummary', 'OBJECT'
GO
COMMIT
