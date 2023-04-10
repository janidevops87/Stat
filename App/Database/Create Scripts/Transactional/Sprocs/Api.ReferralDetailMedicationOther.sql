IF OBJECT_ID('Api.ReferralDetailMedicationOther', 'P') IS NOT NULL
	DROP PROCEDURE Api.ReferralDetailMedicationOther;
GO

CREATE PROCEDURE Api.ReferralDetailMedicationOther
	@referralId int,
	@medicationType varchar(100)
AS

SET NOCOUNT ON;

SELECT * FROM Api.GetReferralMedicationOther(@referralId, @medicationType)
ORDER BY Name;

GO