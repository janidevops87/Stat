

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'RaceInsert')
	BEGIN
		PRINT 'Dropping Procedure RaceInsert'
		DROP Procedure RaceInsert
	END
GO

PRINT 'Creating Procedure RaceInsert'
GO
CREATE Procedure RaceInsert
(
		@RaceID int = null output,
		@RaceName varchar(80) = null,
		@Verified smallint = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: RaceInsert.sql
**	Name: RaceInsert
**	Desc: Inserts Race Based on Id field 
**	Auth: Bret Knoll
**	Date: 9/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	Race
	(
		RaceName,
		Verified,
		Inactive,
		LastModified,
		UpdatedFlag,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@RaceName,
		@Verified,
		@Inactive,
		@LastModified,
		@UpdatedFlag,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @RaceID = SCOPE_IDENTITY()

EXEC RaceSelect @RaceID

GO

GRANT EXEC ON RaceInsert TO PUBLIC
GO
