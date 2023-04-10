IF OBJECT_ID (N'fn_DuplicateSearchRuleNumberOfDays') IS NOT NULL
BEGIN
   PRINT 'DROP FUNCTION fn_DuplicateSearchRuleNumberOfDays'
   PRINT GETDATE()
   DROP FUNCTION fn_DuplicateSearchRuleNumberOfDays
   
END
   PRINT 'CREATE FUNCTION fn_DuplicateSearchRuleNumberOfDays'
   PRINT GETDATE()

GO

CREATE FUNCTION fn_DuplicateSearchRuleNumberOfDays 
(
	@OrganizationID INT,
	@CallTypeID INT ,
	@DuplicateSearchRule NVARCHAR(200) 
)
RETURNS INT
WITH EXECUTE AS CALLER
AS
/******************************************************************************
**	File: fn_DuplicateSearchRuleNumberOfDays.sql
**	Name: fn_DuplicateSearchRuleNumberOfDays
**	Desc: Determine Number of Days for each Duplicate Search Rule
**	Auth: Bret
**	Date: 07/2010
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	3/28/2011	Bret			Initial Function Creation
*******************************************************************************/

BEGIN
DECLARE 
	@NUMBEROFDAYS INT = NULL
	
	SELECT @NUMBEROFDAYS  = NumberOfDaysToSearch
	FROM OrganizationDuplicateSearchRule
	JOIN DuplicateSearchRule ON OrganizationDuplicateSearchRule.DuplicateSearchRuleId = DuplicateSearchRule.DuplicateSearchRuleId
	WHERE OrganizationDuplicateSearchRule.OrganizationId = @OrganizationID
	AND DuplicateSearchRule.DuplicateSearchRule =  @DuplicateSearchRule 
	AND OrganizationDuplicateSearchRule.CallTypeID = @CallTypeID
	
	IF @NUMBEROFDAYS IS NULL
	BEGIN
		SELECT @NUMBEROFDAYS  = NumberOfDaysToSearch
		FROM DuplicateSearchRuleDefault
		JOIN DuplicateSearchRule ON DuplicateSearchRuleDefault.DuplicateSearchRuleId = DuplicateSearchRule.DuplicateSearchRuleId
		WHERE 
		DuplicateSearchRule.DuplicateSearchRule =  @DuplicateSearchRule 
		AND DuplicateSearchRuleDefault.CallTypeID = @CallTypeID
	
	END
    RETURN @NUMBEROFDAYS
END
GO