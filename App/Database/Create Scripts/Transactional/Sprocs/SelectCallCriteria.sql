

IF EXISTS (SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'SelectCallCriteria')
	BEGIN
		PRINT 'Dropping Procedure SelectCallCriteria';
		PRINT GETDATE();
		DROP Procedure SelectCallCriteria;
	END
GO

PRINT 'Creating Procedure SelectCallCriteria';
PRINT GETDATE();
GO
CREATE Procedure SelectCallCriteria
(
		@CallID int = null output
)
AS
/******************************************************************************
**	File: SelectCallCriteria.sql
**	Name: SelectCallCriteria
**	Desc: Selects multiple rows of CallCriteria Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
**	10/14/2019		Mike Berenson		Removed IsNull function from where clause
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT
		CallCriteria.CallID,
		CallCriteria.OrganCriteriaID,
		CallCriteria.BoneCriteriaID,
		CallCriteria.TissueCriteriaID,
		CallCriteria.SkinCriteriaID,
		CallCriteria.ValvesCriteriaID,
		CallCriteria.EyesCriteriaID,
		CallCriteria.OtherCriteriaID,
		CallCriteria.ServiceLevelID
	FROM 
		dbo.CallCriteria 
	WHERE 
		@CallID IS NULL OR CallCriteria.CallID = @CallID;

GO

GRANT EXEC ON SelectCallCriteria TO PUBLIC;
GO
