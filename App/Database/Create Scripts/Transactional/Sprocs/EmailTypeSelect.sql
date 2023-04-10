

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'EmailTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure EmailTypeSelect'
		DROP Procedure EmailTypeSelect
	END
GO

PRINT 'Creating Procedure EmailTypeSelect'
GO
CREATE Procedure EmailTypeSelect
(
		@EmailTypeID int = null output					
)
AS
/******************************************************************************
**	File: EmailTypeSelect.sql
**	Name: EmailTypeSelect
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
		EmailType.EmailTypeID,
		EmailType.EmailType,
		EmailType.LastModified,
		EmailType.LastStatEmployeeID,
		EmailType.AuditLogTypeID
	FROM 
		dbo.EmailType 

	WHERE 
		EmailType.EmailTypeID = ISNULL(@EmailTypeID, EmailType.EmailTypeID)				
	ORDER BY 1
GO

GRANT EXEC ON EmailTypeSelect TO PUBLIC
GO
