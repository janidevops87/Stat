SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_RefQueryApproach]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_RefQueryApproach]
GO





CREATE    PROCEDURE sps_RefQueryApproach
	@vSourceCodeID		int		= null,
	@vApproachID		int		= null,
	@vName			varchar(50)	= null,
	@vTypeID		int		= null
AS

/*	Object:	Stored Procedure dbo.sps_RefQueryApproach
	ISE:	Christopher Carroll
	Date:	11/22/2006
	Inputs:
		vSourceCodeID - Added to allow customized listboxes at the referral's SourceCode level
		vID (optional) - Listbox ID
		vName (optional) - Listbox Name
		vTypeId (optional) - Listbox Type Id

	Notes: This stored procedure replaces embeded SQL code in StatTrac application.
	The sp allows customizing the Approach selection list based on 
	SourceCode.


*/
 
IF	@vName IS Null
  	AND @vApproachID IS Null
	AND @vTypeID IS Null
  BEGIN
	--Get all active items

	IF 	   @vSourceCodeID = 338 -- TXMTF
		OR @vSourceCodeID = 346 -- TXMTF
		OR @vSourceCodeID = 347 -- TXMTF
	  BEGIN
		--Show all active items
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
 		AND ApproachID <> 17 -- Exclude Item 17 (No Jurisdiction)
	  END
 END



ELSE


IF @vName IS Null
AND @vApproachID IS NOT Null
AND @vTypeID IS Null
BEGIN
	-- Get Item specified by the item ID
	SELECT DISTINCT
	ApproachID,
	ApproachName
	FROM Approach
	WHERE ApproachID = @vApproachID 
END


IF @vName IS NOT Null
AND @vApproachID IS Null
AND @vTypeID IS Null
BEGIN
	-- Get Item specified by the item name
	SELECT DISTINCT
	ApproachID,
	ApproachName
	FROM Approach
	WHERE ApproachName = @vName 
END






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

