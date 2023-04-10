IF OBJECT_ID('Api.GetReferralStatusId') IS NOT NULL 
DROP FUNCTION Api.GetReferralStatusId;
GO

CREATE FUNCTION Api.GetReferralStatusId
(
	@referralId int
)
RETURNS TABLE
AS

RETURN(
    SELECT TOP(1)
	CASE IsRecycled
		WHEN 0 THEN 1 -- Complete
		WHEN 1 THEN 2 -- Recycled
	END AS StatusId
	FROM Api.IsReferralRecycled(@referralId)
);
	
GO