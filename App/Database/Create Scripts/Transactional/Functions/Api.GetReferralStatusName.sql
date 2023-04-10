IF OBJECT_ID('Api.GetReferralStatusName') IS NOT NULL 
DROP FUNCTION Api.GetReferralStatusName;
GO

CREATE FUNCTION Api.GetReferralStatusName
(
	@referralId int
)
RETURNS TABLE
AS

RETURN(
    SELECT TOP(1) Name AS StatusName
	FROM Api.GetReferralStatusId(@referralId)
	JOIN Api.ReferralStatus
	ON Id = StatusId
);
	
GO