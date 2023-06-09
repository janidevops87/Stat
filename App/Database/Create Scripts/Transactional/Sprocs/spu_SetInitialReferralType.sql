SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SetInitialReferralType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_SetInitialReferralType]
GO


CREATE PROCEDURE spu_SetInitialReferralType (@CallId int = NULL)

AS

SET NOCOUNT ON

DECLARE @prevRefType int,  -- ReferralTypeId
	@currentRefType int  -- CurrentReferralTypeId


-- Check the current values of ReferralTypeId and CurrentReferralTypeId.
SELECT @prevRefType = IsNull(ReferralTypeId, 0),
	@currentRefType = IsNull(CurrentReferralTypeId, 0)
FROM Referral 
WHERE CallId = @CallId;

-- If the previous type is null (zero) and the current type is not null (zero)
-- save the current type as previous type
--IF (@prevRefType = 0 or @prevRefType = -1) AND @currentRefType <> 0
	BEGIN
		UPDATE Referral SET ReferralTypeId = @currentRefType WHERE CallId = @CallId;
	END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

