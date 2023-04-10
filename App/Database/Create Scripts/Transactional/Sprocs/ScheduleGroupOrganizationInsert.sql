 IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleGroupOrganizationInsert')
	BEGIN
		PRINT 'Dropping Procedure ScheduleGroupOrganizationInsert'
		DROP Procedure ScheduleGroupOrganizationInsert
	END
GO

PRINT 'Creating Procedure ScheduleGroupOrganizationInsert'
GO
CREATE Procedure ScheduleGroupOrganizationInsert
(
		@ScheduleGroupOrganizationID int = null output,
		@ScheduleGroupID int = null,		
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null
)
AS
/******************************************************************************
**	File: ScheduleGroupOrganizationInsert.sql
**	Name: ScheduleGroupOrganizationInsert
**	Desc: Inserts ScheduleGroupOrganization Based on Id field 
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
DECLARE @ExistingScheduleGroupOrganizationID int 

SET  @ExistingScheduleGroupOrganizationID = (SELECT TOP 1 ScheduleGroupOrganizationID FROM ScheduleGroupOrganization WHERE OrganizationID = @OrganizationID AND ScheduleGroupID = @ScheduleGroupID)
IF (coalesce(@ExistingScheduleGroupOrganizationID, 0)) = 0

BEGIN
INSERT	ScheduleGroupOrganization
	(
		ScheduleGroupID,
		OrganizationID,
		LastModified,
		UpdatedFlag
	)
VALUES
	(
		@ScheduleGroupID,
		@OrganizationID,
		coalesce(@LastModified, GetDate()),
		@UpdatedFlag
	)

SET @ScheduleGroupOrganizationID = SCOPE_IDENTITY()

END
ELSE
BEGIN
SET @ScheduleGroupOrganizationID = @ExistingScheduleGroupOrganizationID
END

EXEC ScheduleGroupOrganizationSelect @ScheduleGroupOrganizationID

GO

GRANT EXEC ON ScheduleGroupOrganizationInsert TO PUBLIC
GO
