IF OBJECT_ID('Api.IsReferralRecycled') IS NOT NULL 
DROP FUNCTION Api.IsReferralRecycled;
GO

CREATE FUNCTION Api.IsReferralRecycled
(
	@referralId int
)
RETURNS TABLE
AS

RETURN(
   SELECT CASE 
   WHEN EXISTS(
    -- For recycled referrals Call.CallID is NULL.
    -- In other words, Referral.CallID has value, but 
    -- the call with this ID doesn't exist.
	SELECT Call.CallID FROM Referral 
	INNER JOIN CallRecycle Call  
	ON Call.CallID = Referral.CallID
	WHERE ReferralID = @referralId) 
   THEN 1 
   ELSE 0 
   END AS IsRecycled
);
	
GO