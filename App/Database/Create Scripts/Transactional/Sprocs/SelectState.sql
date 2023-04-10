

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectState')
	BEGIN
		PRINT 'Dropping Procedure SelectState';
		PRINT GETDATE();
		DROP Procedure SelectState;
	END
GO

PRINT 'Creating Procedure SelectState';
PRINT GETDATE();
GO
CREATE Procedure SelectState
(
		@StateID int = null output					
)
AS
/******************************************************************************
**	File: SelectState.sql
**	Name: SelectState
**	Desc: Selects multiple rows of State Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		State.StateID,
		State.StateAbbrv,
		State.StateName,
		State.Verified,
		State.Inactive,
		State.LastModified,
		State.UpdatedFlag
	FROM 
		dbo.State 

	WHERE 
		@StateID IS NULL OR State.StateID = @StateID;

GO

GRANT EXEC ON SelectState TO PUBLIC;
GO
