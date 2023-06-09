SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralSourceCodeID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralSourceCodeID]
GO


CREATE   PROCEDURE sps_ReferralSourceCodeID

	@vCallID	int		= null
AS

/*	Object:	Stored Procedure dbo.sps_ReferralSourceCodeID
	ISE:	Christopher Carroll
	Date:	11/22/2006
	Inputs:
		@vCallID - Referral CallID

	Notes: This procedure returns the SourceCodeID of the referral.
*/

	SELECT	SourceCodeID
	FROM	Call

	WHERE	CallID = @vCallID
	


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

