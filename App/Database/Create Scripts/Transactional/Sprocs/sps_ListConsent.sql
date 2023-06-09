SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ListConsent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ListConsent]
GO



/****** Object:  Stored Procedure dbo.sps_ListConsent    Script Date: 2/24/99 1:12:45 AM ******/
CREATE   PROCEDURE sps_ListConsent
	@vSourceCodeID	int	= null

AS

/*	Object:	Stored Procedure dbo.sps_ListConsent
	ISE:	Christopher Carroll
	Date:	11/21/2006
	Inputs:
		vSourceCodeID - Added to allow additional option for MTN

	Notes: This sp allows customized Consent selection list based on 
	SourceCode.

*/



IF @vSourceCodeID = 338 OR @vSourceCodeID = 346 OR @vSourceCodeID = 347
	BEGIN
		--Show all active items for sourcecode above
		SELECT DISTINCT
		ConsentID,
		ConsentName
		FROM Consent
		WHERE Inactive <> 1
	END
ELSE 
	  BEGIN
		SELECT DISTINCT
		ConsentID,
		ConsentName
		FROM Consent
		WHERE Inactive <> 1
 		-- de-activate Item 10 No Jurisdiction
		AND ConsentID <> 10
	  END
 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

