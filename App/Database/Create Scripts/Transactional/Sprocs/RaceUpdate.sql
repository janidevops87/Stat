

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'RaceUpdate')
	BEGIN
		PRINT 'Dropping Procedure RaceUpdate'
		DROP Procedure RaceUpdate
	END
GO

PRINT 'Creating Procedure RaceUpdate'
GO
CREATE Procedure RaceUpdate
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
**	File: RaceUpdate.sql
**	Name: RaceUpdate
**	Desc: Updates Race Based on Id field 
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

UPDATE
	dbo.Race 	
SET 
		RaceName = @RaceName,
		Verified = @Verified,
		Inactive = @Inactive,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	RaceID = @RaceID 				

GO

GRANT EXEC ON RaceUpdate TO PUBLIC
GO
