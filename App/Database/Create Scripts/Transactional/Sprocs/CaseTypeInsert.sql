

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CaseTypeInsert')
	BEGIN
		PRINT 'Dropping Procedure CaseTypeInsert'
		DROP Procedure CaseTypeInsert
	END
GO

PRINT 'Creating Procedure CaseTypeInsert'
GO
CREATE Procedure CaseTypeInsert
(
		@CaseTypeId int = null,
		@CaseType nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: CaseTypeInsert.sql
**	Name: CaseTypeInsert
**	Desc: Inserts CaseType Based on Id field 
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

INSERT	CaseType
	(
		CaseType,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@CaseType,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @CaseTypeID = SCOPE_IDENTITY()

EXEC CaseTypeSelect @CaseTypeID

GO

GRANT EXEC ON CaseTypeInsert TO PUBLIC
GO
