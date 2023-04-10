

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SecurityRuleListSelect')
	BEGIN
		PRINT 'Dropping Procedure SecurityRuleListSelect'
		DROP Procedure SecurityRuleListSelect
	END
GO

PRINT 'Creating Procedure SecurityRuleListSelect'
GO
CREATE Procedure SecurityRuleListSelect
(
		@SecurityRuleID int = null output					
)
AS
/******************************************************************************
**	File: SecurityRuleListSelect.sql
**	Name: SecurityRuleListSelect
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
		SecurityRule.SecurityRuleID AS ListId,
		SecurityRule.SecurityRule AS FieldValue
	FROM 
		dbo.SecurityRule 
	WHERE 
		SecurityRule.SecurityRuleID = ISNULL(@SecurityRuleID, SecurityRule.SecurityRuleID)				
	ORDER BY 2
GO

GRANT EXEC ON SecurityRuleListSelect TO PUBLIC
GO
