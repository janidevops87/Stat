SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ListApproach]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ListApproach]
GO




/****** Object:  Stored Procedure dbo.sps_ListApproach    Script Date: 2/24/99 1:12:45 AM ******/
CREATE  PROCEDURE sps_ListApproach
	@vSourceCodeID	int = null
AS
/*	Object:	Stored Procedure dbo.sps_ListApproprite
	ISE:	Christopher Carroll
	Date:	11/21/2006
	Inputs:
		vSourceCodeID - Added to allow additional option for MTN

	Notes: This sp allows customized Appropriate selection list based on 
	SourceCode.

*/


IF @vSourceCodeID = 338 OR @vSourceCodeID = 346 OR @vSourceCodeID = 347
	BEGIN
		--Show all active items for sourcecode above
		SELECT DISTINCT
		ApproachID,
		ApproachName
		FROM Approach
		WHERE Inactive <> 1
	END
ELSE 
	  BEGIN
		SELECT DISTINCT
		ApproachID,
		ApproachName
		FROM Approach
		WHERE Inactive <> 1
 		-- exclude Item 17 No Jurisdiction
		AND ApproachID <> 17
	  END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

