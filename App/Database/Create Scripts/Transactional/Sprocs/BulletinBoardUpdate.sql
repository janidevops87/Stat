

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'BulletinBoardUpdate')
	BEGIN
		PRINT 'Dropping Procedure BulletinBoardUpdate'
		DROP Procedure BulletinBoardUpdate
	END
GO

PRINT 'Creating Procedure BulletinBoardUpdate'
GO
CREATE Procedure BulletinBoardUpdate
(
		@BulletinBoardID int = null output,
		@DateTimeStatus nvarchar(80) = null,
		@Organization nvarchar(80) = null,
		@Alert nvarchar(255) = null,
		@CreateDate datetime = null,
		@OrganizationID int = null,
		@SavedBy nvarchar(80) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: BulletinBoardUpdate.sql
**	Name: BulletinBoardUpdate
**	Desc: Updates BulletinBoard Based on BulletinBoardID field 
**	Auth: ccarroll
**	Date: 9/13/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	9/13/2010		ccarroll			Initial Sproc Creation
**  08/08/2011		ccarroll			Removed CreateDate to from update
*******************************************************************************/

UPDATE
	dbo.BulletinBoard 	
SET 
		Organization = @Organization,
		Alert = @Alert,
		--CreateDate = IsNull(@CreateDate,CreateDate),
		OrganizationID = IsNull(@OrganizationID, OrganizationID),
		LastModified = IsNull(@LastModified, GetDate()),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	BulletinBoardID = @BulletinBoardID 				

GO

GRANT EXEC ON BulletinBoardUpdate TO PUBLIC
GO
