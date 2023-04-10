 IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaProcessorInsert')
	BEGIN
		PRINT 'Dropping Procedure CriteriaProcessorInsert'
		DROP Procedure CriteriaProcessorInsert
	END
GO

PRINT 'Creating Procedure CriteriaProcessorInsert'
GO
CREATE Procedure CriteriaProcessorInsert
(
		@CriteriaProcessorID int = null output,
		@CriteriaID int = null,
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaProcessorInsert.sql
**	Name: CriteriaProcessorInsert
**	Desc: Inserts CriteriaProcessor Based on Id field 
**	Auth: ccarroll
**	Date: 12/18/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/18/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	CriteriaProcessor
	(
		CriteriaID,
		OrganizationID,
		LastModified,
		UpdatedFlag,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@CriteriaID,
		@OrganizationID,
		@LastModified,
		@UpdatedFlag,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @CriteriaProcessorID = SCOPE_IDENTITY()

EXEC CriteriaProcessorSelect @CriteriaProcessorID

GO

GRANT EXEC ON CriteriaProcessorInsert TO PUBLIC
GO
