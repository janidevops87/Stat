

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PersonTypeUpdate')
	BEGIN
		PRINT 'Dropping Procedure PersonTypeUpdate'
		DROP Procedure PersonTypeUpdate
	END
GO

PRINT 'Creating Procedure PersonTypeUpdate'
GO
CREATE Procedure PersonTypeUpdate
(
		@PersonTypeID int = null output,
		@PersonTypeName varchar(50) = null,
		@Verified smallint = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@PersonTypeProcurmentAgency smallint = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: PersonTypeUpdate.sql
**	Name: PersonTypeUpdate
**	Desc: Updates PersonType Based on Id field 
**	Auth: Bret Knoll
**	Date: 9/15/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/15/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.PersonType 	
SET 
		PersonTypeName = @PersonTypeName,
		Verified = @Verified,
		Inactive = @Inactive,
		LastModified = GetDate(),
		PersonTypeProcurmentAgency = @PersonTypeProcurmentAgency,
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	PersonTypeID = @PersonTypeID 				

GO

GRANT EXEC ON PersonTypeUpdate TO PUBLIC
GO
