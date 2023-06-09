SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ListAppropriate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ListAppropriate]
GO



/****** Object:  Stored Procedure dbo.sps_ListAppropriate    Script Date: 2/24/99 1:12:45 AM ******/
CREATE   PROCEDURE sps_ListAppropriate
	@vSourceCodeID	int	= null

AS

/*	Object:	Stored Procedure dbo.sps_ListApproprite
	ISE:	Christopher Carroll
	Date:	11/21/2006
	Inputs:
		vSourceCodeID - Added to allow additional option for MTN

	Notes: This sp allows customized Appropriate selection list based on 
	SourceCode.

*/



IF @vSourceCodeID = 325 OR @vSourceCodeID = 22
	BEGIN
		--Show all active items for sourcecode above
		SELECT DISTINCT
		AppropriateID,
		AppropriateName
		FROM Appropriate
		WHERE Inactive <> 1
	END
ELSE 
	  BEGIN
		SELECT DISTINCT
		AppropriateID,
		AppropriateName
		FROM Appropriate
		WHERE Inactive <> 1
 		-- Item 7 (No Neuro Injury) is for MTN only
		AND AppropriateID <> 7
	  END
 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

