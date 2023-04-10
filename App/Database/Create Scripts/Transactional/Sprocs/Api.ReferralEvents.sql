IF OBJECT_ID('Api.ReferralEvents', 'P') IS NOT NULL
	DROP PROCEDURE Api.ReferralEvents;
GO

CREATE PROCEDURE API.ReferralEvents
	@webReportGroupId int,
	@referralId int
AS

SET NOCOUNT ON;

DECLARE @callId as INT = 
	(SELECT CallID FROM dbo.Referral WHERE ReferralID = @referralId);

DECLARE @organizationId AS INT = 
	Api.GetOrganizationIdByWebReportGroupId(@webReportGroupId);

SELECT * from Api.fn_GetEvents(@organizationId, @callId);

GO