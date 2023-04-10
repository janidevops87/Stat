IF OBJECT_ID('Api.ReferralDetailSecondary', 'P') IS NOT NULL
	DROP PROCEDURE Api.ReferralDetailSecondary;
GO

CREATE PROCEDURE Api.ReferralDetailSecondary
	@webReportGroupId int,
	@referralId int
AS

SET NOCOUNT ON;

SELECT * FROM Api.GetReferralDetailSecondaryById(@webReportGroupId, @referralId);

GO