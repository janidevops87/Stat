/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Referral_MessageCountSummary
	(
	YearID int NULL,
	MonthID int NULL,
	DayID int NULL,
	OrganizationID int NULL,
	SourceCodeID int NULL,
	TotalMessages int NULL,
	TotalImports int NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.Referral_MessageCountSummary)
	 EXEC('INSERT INTO dbo.Tmp_Referral_MessageCountSummary (YearID, MonthID, DayID, OrganizationID, SourceCodeID, TotalMessages, TotalImports)
		SELECT YearID, MonthID, DayID, OrganizationID, SourceCodeID, CONVERT(int, TotalMessages), CONVERT(int, TotalImports) FROM dbo.Referral_MessageCountSummary WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.Referral_MessageCountSummary
GO
EXECUTE sp_rename N'dbo.Tmp_Referral_MessageCountSummary', N'Referral_MessageCountSummary', 'OBJECT' 
GO
COMMIT
