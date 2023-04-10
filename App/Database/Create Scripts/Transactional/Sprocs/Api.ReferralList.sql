IF OBJECT_ID('Api.ReferralList', 'P') IS NOT NULL
	DROP PROCEDURE Api.ReferralList;
GO

CREATE PROCEDURE Api.ReferralList
	@webReportGroupId int,
	@startDateTimeMT datetime2, -- Mountain Time
	@endDateTimeMT datetime2 -- Mountain Time
AS
SET NOCOUNT ON;

SELECT DISTINCT dbo.Referral.ReferralID
FROM Referral      
JOIN Call ON Call.CallID = Referral.CallID 
WHERE 
	CallDateTime >= @startDateTimeMT 
	AND
	CallDateTime <= @endDateTimeMT
	AND
	[dbo].[Referral].ReferralCallerOrganizationID IN 
		(SELECT * FROM Api.GetWebReportGroupOrganizationIds(@webReportGroupId))
	AND 
	[dbo].[call].SourceCodeID IN 
		(SELECT * FROM Api.GetWebReportGroupSourceCodes(@webReportGroupId));
GO