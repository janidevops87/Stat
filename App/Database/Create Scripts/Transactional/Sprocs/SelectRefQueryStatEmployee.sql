
IF EXISTS (SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'SelectRefQueryStatEmployee')
	BEGIN
		PRINT 'Dropping Procedure SelectRefQueryStatEmployee';
		DROP Procedure SelectRefQueryStatEmployee;
	END
GO

PRINT 'Creating Procedure SelectRefQueryStatEmployee';
GO
CREATE Procedure SelectRefQueryStatEmployee
(
		@PersonID INT = NULL,
		@StatEmployeeID INT = NULL,
		@PersonFirst VARCHAR(50) = NULL,
		@PersonLast VARCHAR(50) = NULL,
		@DisplayInactive bit = 1
)
AS
/******************************************************************************
**	File: SelectRefQueryStatEmployee.sql
**	Name: SelectRefQueryStatEmployee
**	Desc: Selects Employee ID & name
**	Auth: Mike Berenson
**	Date: 10/14/2019
**	Called By: StatQuery.RefQueryStatEmployee
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/14/2019		Mike Berenson		Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT 
		se.StatEmployeeID,
		p.PersonFirst + ' ' + p.PersonLast
	FROM 
		StatEmployee se
		JOIN Person p ON p.PersonID = se.PersonID
	WHERE
		(@StatEmployeeID IS NULL OR se.StatEmployeeID = @StatEmployeeID)
		AND (@PersonID IS NULL OR p.PersonID = @PersonID)
		AND (@PersonFirst IS NULL OR p.PersonFirst = @PersonFirst)
		AND (@PersonLast IS NULL OR p.PersonLast = @PersonLast)
		AND (@DisplayInactive = 1 OR ( @DisplayInactive = 0 AND p.Inactive = 0))
	GROUP BY 
		se.StatEmployeeID,
		p.PersonFirst + ' ' + p.PersonLast
	ORDER BY 
		p.PersonFirst + ' ' + p.PersonLast;

GO

GRANT EXEC ON SelectRefQueryStatEmployee TO PUBLIC;
GO
