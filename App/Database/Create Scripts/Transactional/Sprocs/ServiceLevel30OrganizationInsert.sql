 IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevel30OrganizationInsert')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevel30OrganizationInsert'
		DROP Procedure ServiceLevel30OrganizationInsert
	END
GO

PRINT 'Creating Procedure ServiceLevel30OrganizationInsert'
GO
CREATE Procedure ServiceLevel30OrganizationInsert
(
		@ServiceLevelOrganizationID int = null output,
		@ServiceLevelID int = null,		
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null
)
AS
/******************************************************************************
**	File: ServiceLevel30OrganizationInsert.sql
**	Name: ServiceLevel30OrganizationInsert
**	Desc: Inserts ServiceLevel30Organization Based on Id field 
**	Auth: ccarroll	
**	Date: 05/16/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	05/16/2011		ccarroll		Initial Sproc Creation
**	09/07/2012		ccarroll		Add check for to prevent duplicate insert HS:33091 (wi:4929)
*******************************************************************************/
DECLARE @ExistingServiceLevelOrganizationID int 

SET  @ExistingServiceLevelOrganizationID = (SELECT TOP 1 ServiceLevelOrganizationID FROM ServiceLevel30Organization WHERE OrganizationID = @OrganizationID AND ServicelevelID = @ServicelevelID)
IF (coalesce(@ExistingServiceLevelOrganizationID, 0)) = 0

BEGIN
	INSERT	ServiceLevel30Organization
		(
			ServicelevelID,
			OrganizationID,
			LastModified,
			UpdatedFlag
		)
	VALUES
		(
			@ServicelevelID,
			@OrganizationID,
			coalesce(@LastModified, GetDate()),
			@UpdatedFlag
		)

	SET @ServiceLevelOrganizationID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	SET @ServiceLevelOrganizationID = @ExistingServiceLevelOrganizationID
END

EXEC ServiceLevel30OrganizationSelect @ServiceLevelOrganizationID

GO

GRANT EXEC ON ServiceLevel30OrganizationInsert TO PUBLIC
GO
