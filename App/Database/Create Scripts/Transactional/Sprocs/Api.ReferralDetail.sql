IF OBJECT_ID('Api.ReferralDetail', 'P') IS NOT NULL
	DROP PROCEDURE Api.ReferralDetail;
GO

CREATE PROCEDURE API.ReferralDetail
	@webReportGroupId int,
	@referralId int
AS

SET NOCOUNT ON;
SELECT * FROM Api.GetReferralDetailById(@webReportGroupId, @referralId);
GO