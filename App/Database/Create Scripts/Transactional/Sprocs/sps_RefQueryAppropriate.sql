SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_RefQueryAppropriate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_RefQueryAppropriate]
GO





CREATE    PROCEDURE sps_RefQueryAppropriate
	@vSourceCodeID		int		= null,
	@vAppropriateID		int		= null,
	@vName			varchar(50)	= null,
	@vTypeID		int		= null
AS

/*	Object:	Stored Procedure dbo.sps_RefQueryAppropriate
	ISE:	Christopher Carroll
	Date:	11/13/2006
	Inputs:
		vSourceCodeID - Added to allow additional option for MTN
		vID (optional) - Listbox ID
		vName (optional) - Listbox Name
		vTypeId (optional) - Listbox Type Id

	Notes: This stored procedure replaces embeded SQL code in StatTrac application.
	The sp allows customizing the Appropriate selection list based on 
	SourceCode.

	

*/
 
IF	@vName IS Null
  	AND @vAppropriateID IS Null
	AND @vTypeID IS Null
  BEGIN
	--Get all active items

	IF @vSourceCodeID = 325 OR @vSourceCodeID = 22
	  BEGIN
		--Show all active items
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
 END



ELSE


IF @vName IS Null
AND @vAppropriateID IS NOT Null
AND @vTypeID IS Null
BEGIN
	-- Get Item specified by the item ID
	SELECT DISTINCT
	AppropriateID,
	AppropriateName
	FROM Appropriate
	WHERE AppropriateID = @vAppropriateID 
END


IF @vName IS NOT Null
AND @vAppropriateID IS Null
AND @vTypeID IS Null
BEGIN
	-- Get Item specified by the item name
	SELECT DISTINCT
	AppropriateID,
	AppropriateName
	FROM Appropriate
	WHERE AppropriateName = @vName 
END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

