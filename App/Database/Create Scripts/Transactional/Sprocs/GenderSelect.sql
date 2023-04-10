

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GenderSelect')
	BEGIN
		PRINT 'Dropping Procedure GenderSelect'
		DROP Procedure GenderSelect
	END
GO

PRINT 'Creating Procedure GenderSelect'
GO
CREATE Procedure GenderSelect
(
		@GenderID int = null output					
)
AS
/******************************************************************************
**	File: GenderSelect.sql
**	Name: GenderSelect
**	Desc: Selects multiple rows of Gender Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 9/15/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/15/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Gender.GenderID,
		Gender.Gender,
		Gender.GenderAbbreviation,
		Gender.LastModified,
		Gender.LastStatEmployeeID,
		Gender.AuditLogTypeID
	FROM 
		dbo.Gender 

	WHERE 
		Gender.GenderID = ISNULL(@GenderID, Gender.GenderID)				
	ORDER BY 1
GO

GRANT EXEC ON GenderSelect TO PUBLIC
GO
