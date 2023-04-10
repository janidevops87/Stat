IF OBJECT_ID('Api.ReferralDetailMedication', 'P') IS NOT NULL
	DROP PROCEDURE Api.ReferralDetailMedication;
GO

CREATE PROCEDURE Api.ReferralDetailMedication
	@referralId int,
	@medicationType varchar(100) = NULL
AS

SET NOCOUNT ON;

SELECT * FROM Api.GetReferralMedication(@referralId, @medicationType)
ORDER BY Name;

GO