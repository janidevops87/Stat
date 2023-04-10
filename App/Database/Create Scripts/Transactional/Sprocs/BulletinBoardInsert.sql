

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'BulletinBoardInsert')
	BEGIN
		PRINT 'Dropping Procedure BulletinBoardInsert'
		DROP Procedure BulletinBoardInsert
	END
GO

PRINT 'Creating Procedure BulletinBoardInsert'
GO
CREATE Procedure BulletinBoardInsert
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
**	File: BulletinBoardInsert.sql
**	Name: BulletinBoardInsert
**	Desc: Inserts BulletinBoard Based on BulletinBoardID field 
**	Auth: ccarroll
**	Date: 9/13/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	9/13/2010		ccarroll		Initial Sproc Creation
**	08/08/2011		ccarroll		Use @LastModified for LastModified and CreateDate
**									because both datetimes need to be the same.
*******************************************************************************/

INSERT	BulletinBoard
	(
		Organization,
		Alert,
		CreateDate,
		OrganizationID,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@Organization,
		@Alert,
		IsNull(@LastModified, GetDate()), --CreateDate
		@OrganizationID,
		IsNull(@LastModified, GetDate()), --LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @BulletinBoardID = SCOPE_IDENTITY()

EXEC BulletinBoardSelect @BulletinBoardID

GO

GRANT EXEC ON BulletinBoardInsert TO PUBLIC
GO
