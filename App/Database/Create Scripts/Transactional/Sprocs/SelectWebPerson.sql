

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectWebPerson')
	BEGIN
		PRINT 'Dropping Procedure SelectWebPerson'
		PRINT GETDATE()
		DROP Procedure SelectWebPerson
	END
GO

PRINT 'Creating Procedure SelectWebPerson'
PRINT GETDATE()
GO
CREATE Procedure SelectWebPerson
(
		@WebPersonID int = null output,
		@PersonID int = null					
)
AS
/******************************************************************************
**	File: SelectWebPerson.sql
**	Name: SelectWebPerson
**	Desc: Selects multiple rows of WebPerson Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
**	07/11/2018		Ilya Osipov			Removed WebPersonPassword from the code
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		WebPerson.WebPersonID,
		WebPerson.WebPersonUserName,
		WebPerson.PersonID,
		WebPerson.UnusedField1,
		WebPerson.LastModified,
		WebPerson.WebPersonSessionCounter,
		WebPerson.UnusedField2,
		WebPerson.WebPersonLastSessionAccess,
		WebPerson.WebPersonEmail,
		WebPerson.UpdatedFlag,
		WebPerson.WebPersonUserAgent,
		WebPerson.Access,
		WebPerson.LastStatEmployeeID,
		WebPerson.AuditLogTypeID
	FROM 
		dbo.WebPerson 
	WHERE 
		WebPerson.WebPersonID = ISNULL(@WebPersonID, WebPerson.WebPersonID)
	AND
		WebPerson.PersonID = ISNULL(@PersonID, WebPerson.PersonID)				

GO

GRANT EXEC ON SelectWebPerson TO PUBLIC
GO
