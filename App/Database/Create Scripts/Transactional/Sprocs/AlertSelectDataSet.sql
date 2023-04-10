

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AlertSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure AlertSelectDataSet'
		DROP Procedure AlertSelectDataSet
	END
GO

PRINT 'Creating Procedure AlertSelectDataSet'
GO
CREATE Procedure AlertSelectDataSet
(
		@AlertID int
)
AS
/******************************************************************************
**	File: AlertSelectDataSet.sql
**	Name: AlertSelectDataSet
**	Desc: Selects multiple rows of Alert Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/26/2011		Bret Knoll			Initial Sproc Creation (9376)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	
	EXEC AlertSelect @AlertID = @AlertID
	EXEC AlertOrganizationSelect @AlertID = @AlertID
	EXEC AlertSourceCodeSelect @AlertID = @AlertID
	
GO

GRANT EXEC ON AlertSelectDataSet TO PUBLIC
GO
