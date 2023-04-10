

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CountryCodeUpdate')
	BEGIN
		PRINT 'Dropping Procedure CountryCodeUpdate'
		DROP Procedure CountryCodeUpdate
	END
GO

PRINT 'Creating Procedure CountryCodeUpdate'
GO
CREATE Procedure CountryCodeUpdate
(
		@CountryCodeId int = null,
		@CountryCode nvarchar(10) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: CountryCodeUpdate.sql
**	Name: CountryCodeUpdate
**	Desc: Updates CountryCode Based on Id field 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.CountryCode 	
SET 
		CountryCode = @CountryCode,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	CountryCodeId = @CountryCodeId 				

GO

GRANT EXEC ON CountryCodeUpdate TO PUBLIC
GO
