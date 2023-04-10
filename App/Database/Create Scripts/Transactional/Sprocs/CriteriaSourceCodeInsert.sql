

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaSourceCodeInsert')
	BEGIN
		PRINT 'Dropping Procedure CriteriaSourceCodeInsert'
		DROP Procedure CriteriaSourceCodeInsert
	END
GO

PRINT 'Creating Procedure CriteriaSourceCodeInsert'
GO
CREATE Procedure CriteriaSourceCodeInsert
(
		@CriteriaSourceCodeID int = null output,
		@CriteriaID int = null,
		@SourceCodeID int = null,
		@LastModified smalldatetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@SourceCodeName varchar(10)					
)
AS
/******************************************************************************
**	File: CriteriaSourceCodeInsert.sql
**	Name: CriteriaSourceCodeInsert
**	Desc: Inserts CriteriaSourceCode Based on Id field 
**	Auth: ccarroll
**	Date: 12/21/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/21/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	CriteriaSourceCode
	(
		CriteriaID,
		SourceCodeID,
		LastModified,
		UpdatedFlag,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@CriteriaID,
		@SourceCodeID,
		@LastModified,
		@UpdatedFlag,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @CriteriaSourceCodeID = SCOPE_IDENTITY()

EXEC CriteriaSourceCodeSelect @CriteriaSourceCodeID

GO

GRANT EXEC ON CriteriaSourceCodeInsert TO PUBLIC
GO
