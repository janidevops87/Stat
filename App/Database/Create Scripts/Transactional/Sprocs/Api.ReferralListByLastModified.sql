IF OBJECT_ID('Api.ReferralListByLastModified', 'P') IS NOT NULL
	DROP PROCEDURE Api.ReferralListByLastModified;
GO

CREATE PROCEDURE Api.ReferralListByLastModified
	@webReportGroupId int,
	@startDateTimeMT datetime2, -- Mountain Time
	@endDateTimeMT datetime2 -- Mountain Time
AS

/******************************************************************************
  ** File: Api.ReferralListByLastModified.sql 
  ** Name: Api.ReferralListByLastModified
  ** Desc: Returns referrals filtered by LastModified column.
  ** Auth: Andrey Savin
  ** Date: 4/12/2018
  *******************************************************************************/ 

SET NOCOUNT ON;

SELECT DISTINCT r.ReferralID
FROM Referral r
JOIN Call c ON c.CallID = r.CallID 
WHERE 
	r.LastModified >= @startDateTimeMT 
	AND
	r.LastModified <= @endDateTimeMT
	AND
	r.ReferralCallerOrganizationID IN 
		(SELECT * FROM Api.GetWebReportGroupOrganizationIds(@webReportGroupId))
	AND 
	c.SourceCodeID IN 
		(SELECT * FROM Api.GetWebReportGroupSourceCodes(@webReportGroupId));
GO