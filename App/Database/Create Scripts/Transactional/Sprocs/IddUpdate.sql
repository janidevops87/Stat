

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'IddUpdate')
	BEGIN
		PRINT 'Dropping Procedure IddUpdate'
		DROP Procedure IddUpdate
	END
GO

PRINT 'Creating Procedure IddUpdate'
GO
CREATE Procedure IddUpdate
(
		@IddId int = null,
		@Idd nvarchar(10) = null,		
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null,
		@CountryId int = null
)
AS
/******************************************************************************
**	File: IddUpdate.sql
**	Name: IddUpdate
**	Desc: Updates Idd Based on Id field 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.Idd 	
SET 
		Idd = @Idd,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3), --- Modify,
		CountryId = @CountryId
WHERE 
	IddId = @IddId 				

GO

GRANT EXEC ON IddUpdate TO PUBLIC
GO
