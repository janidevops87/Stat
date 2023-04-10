

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CaseTypeUpdate')
	BEGIN
		PRINT 'Dropping Procedure CaseTypeUpdate'
		DROP Procedure CaseTypeUpdate
	END
GO

PRINT 'Creating Procedure CaseTypeUpdate'
GO
CREATE Procedure CaseTypeUpdate
(
		@CaseTypeId int = null,
		@CaseType nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: CaseTypeUpdate.sql
**	Name: CaseTypeUpdate
**	Desc: Updates CaseType Based on Id field 
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
	dbo.CaseType 	
SET 
		CaseType = @CaseType,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	CaseTypeId = @CaseTypeId 				

GO

GRANT EXEC ON CaseTypeUpdate TO PUBLIC
GO
