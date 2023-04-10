 IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaOrganizationInsert')
	BEGIN
		PRINT 'Dropping Procedure CriteriaOrganizationInsert'
		DROP Procedure CriteriaOrganizationInsert
	END
GO

PRINT 'Creating Procedure CriteriaOrganizationInsert'
GO
CREATE Procedure CriteriaOrganizationInsert
(
		@CriteriaOrganizationID int = null output,
		@CriteriaID int = null,
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaOrganizationInsert.sql
**	Name: CriteriaOrganizationInsert
**	Desc: Inserts CriteriaOrganization Based on Id field 
**	Auth: ccarroll
**	Date: 12/16/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	12/16/2009		ccarroll		Initial Sproc Creation
**	07/09/2010		ccarroll		added this note for development build (GenerateSQL)
**	09/07/2012		ccarroll		Add check for to prevent duplicate insert HS:33091 (wi:4929)
*******************************************************************************/
DECLARE @ExistingCriteriaOrganizationID int 

SET  @ExistingCriteriaOrganizationID = (SELECT TOP 1 CriteriaOrganizationID FROM CriteriaOrganization WHERE OrganizationID = @OrganizationID AND CriteriaID = @CriteriaID)
IF (coalesce(@ExistingCriteriaOrganizationID, 0)) = 0

BEGIN
	INSERT	CriteriaOrganization
		(
			CriteriaID,
			OrganizationID,
			LastModified,
			UpdatedFlag,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@CriteriaID,
			@OrganizationID,
			@LastModified,
			@UpdatedFlag,
			@LastStatEmployeeID,
			coalesce(@AuditLogTypeID, 1) /* insert */
		)
	SET @CriteriaOrganizationID = SCOPE_IDENTITY()

END
ELSE
BEGIN
	SET @CriteriaOrganizationID = @ExistingCriteriaOrganizationID
END

EXEC CriteriaOrganizationSelect @CriteriaOrganizationID

GO

GRANT EXEC ON CriteriaOrganizationInsert TO PUBLIC
GO
