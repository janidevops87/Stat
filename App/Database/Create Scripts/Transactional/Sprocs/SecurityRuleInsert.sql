

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SecurityRuleInsert')
	BEGIN
		PRINT 'Dropping Procedure SecurityRuleInsert'
		DROP Procedure SecurityRuleInsert
	END
GO

PRINT 'Creating Procedure SecurityRuleInsert'
GO
CREATE Procedure SecurityRuleInsert
(
		@SecurityRuleID int = null output,
		@SecurityRule nvarchar(100) = null,
		@Expression nvarchar(4000) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: SecurityRuleInsert.sql
**	Name: SecurityRuleInsert
**	Desc: Inserts SecurityRule Based on Id field 
**	Auth: Bret Knoll
**	Date: 9/4/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/4/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	SecurityRule
	(
		SecurityRule,
		Expression,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@SecurityRule,
		@Expression,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @SecurityRuleID = SCOPE_IDENTITY()

EXEC SecurityRuleSelect @SecurityRuleID

GO

GRANT EXEC ON SecurityRuleInsert TO PUBLIC
GO
