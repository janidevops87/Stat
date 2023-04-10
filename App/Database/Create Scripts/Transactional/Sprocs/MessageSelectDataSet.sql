

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'MessageSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure MessageSelectDataSet'
		PRINT Getdate()
		DROP Procedure MessageSelectDataSet
	END
GO

PRINT 'Creating Procedure MessageSelectDataSet'
PRINT Getdate()
GO
CREATE Procedure MessageSelectDataSet
(
		@CallID int = null
)
AS
/******************************************************************************
**	File: MessageSelectDataSet.sql
**	Name: MessageSelectDataSet
**	Desc: Selects multiple rows of Message Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/7/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/7/2011		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	EXEC CallSelect @CallID = @CallID
	EXEC MessageSelect @CallID = @CallID


GRANT EXEC ON MessageSelectDataSet TO PUBLIC
GO
