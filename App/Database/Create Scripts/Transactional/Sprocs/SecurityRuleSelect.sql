

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SecurityRuleSelect')
	BEGIN
		PRINT 'Dropping Procedure SecurityRuleSelect'
		DROP Procedure SecurityRuleSelect
	END
GO

PRINT 'Creating Procedure SecurityRuleSelect'
GO
CREATE Procedure SecurityRuleSelect
(
		@SecurityRuleID int = null output					
)
AS
/******************************************************************************
**	File: SecurityRuleSelect.sql
**	Name: SecurityRuleSelect
**	Desc: Selects multiple rows of SecurityRule Based on Id  fields 
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
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		SecurityRule.SecurityRuleID,
		SecurityRule.SecurityRule,
		REPLACE(SecurityRule.Expression, '&quot;', '"') Expression,
		SecurityRule.LastModified,
		SecurityRule.LastStatEmployeeID,
		SecurityRule.AuditLogTypeID
	FROM 
		dbo.SecurityRule 

	WHERE 
		SecurityRule.SecurityRuleID = ISNULL(@SecurityRuleID, SecurityRule.SecurityRuleID)				
	ORDER BY 2
GO

GRANT EXEC ON SecurityRuleSelect TO PUBLIC
GO
