

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AlertOrganizationInsert')
	BEGIN
		PRINT 'Dropping Procedure AlertOrganizationInsert'
		DROP Procedure AlertOrganizationInsert
	END
GO

PRINT 'Creating Procedure AlertOrganizationInsert'
GO
CREATE Procedure AlertOrganizationInsert
(
		@AlertOrganizationID int = null output,
		@AlertID int = null,
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null					
)
AS
/******************************************************************************
**	File: AlertOrganizationInsert.sql
**	Name: AlertOrganizationInsert
**	Desc: Inserts AlertOrganization Based on Id field 
**	Auth: Bret Knoll
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	1/26/2011		Bret Knoll		Initial Sproc Creation (9376)
**	09/07/2012		ccarroll		Add check for to prevent duplicate insert HS:33091 (wi:4929)
*******************************************************************************/
DECLARE @ExistingAlertOrganizationID int 

SET  @ExistingAlertOrganizationID = (SELECT TOP 1 AlertOrganizationID FROM AlertOrganization WHERE OrganizationID = @OrganizationID AND AlertID = @AlertID)
IF (coalesce(@ExistingAlertOrganizationID, 0)) = 0

BEGIN
	INSERT	AlertOrganization
		(
			AlertID,
			OrganizationID,
			LastModified,
			UpdatedFlag
		)
	VALUES
		(
			@AlertID,
			@OrganizationID,
			@LastModified,
			@UpdatedFlag
		)
	SET @AlertOrganizationID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	SET @AlertOrganizationID = @ExistingAlertOrganizationID
END

EXEC AlertOrganizationSelect @AlertOrganizationID

GO

GRANT EXEC ON AlertOrganizationInsert TO PUBLIC
GO
