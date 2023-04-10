

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'EmailTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure EmailTypeListSelect'
		DROP Procedure EmailTypeListSelect
	END
GO

PRINT 'Creating Procedure EmailTypeListSelect'
GO
CREATE Procedure EmailTypeListSelect
(
		@EmailTypeID int = null output					
)
AS
/******************************************************************************
**	File: EmailTypeListSelect.sql
**	Name: EmailTypeListSelect
**	Desc: Selects multiple rows of EmailType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 10/6/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/6/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		EmailType.EmailTypeID AS ListId,
		EmailType.EmailType AS FieldValue
	FROM 
		dbo.EmailType 
	WHERE 
		EmailType.EmailTypeID = ISNULL(@EmailTypeID, EmailType.EmailTypeID)				
	ORDER BY 2
GO

GRANT EXEC ON EmailTypeListSelect TO PUBLIC
GO
