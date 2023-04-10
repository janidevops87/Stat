

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SecurityRuleUpdate')
	BEGIN
		PRINT 'Dropping Procedure SecurityRuleUpdate'
		DROP Procedure SecurityRuleUpdate
	END
GO

PRINT 'Creating Procedure SecurityRuleUpdate'
GO
CREATE Procedure SecurityRuleUpdate
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
**	File: SecurityRuleUpdate.sql
**	Name: SecurityRuleUpdate
**	Desc: Updates SecurityRule Based on Id field 
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

UPDATE
	dbo.SecurityRule 	
SET 
		SecurityRule = @SecurityRule,
		Expression = @Expression,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	SecurityRuleID = @SecurityRuleID 				

GO

GRANT EXEC ON SecurityRuleUpdate TO PUBLIC
GO
