

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PersonTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure PersonTypeSelect'
		DROP Procedure PersonTypeSelect
	END
GO

PRINT 'Creating Procedure PersonTypeSelect'
GO
CREATE Procedure PersonTypeSelect
(
		@PersonTypeID int = null output					
)
AS
/******************************************************************************
**	File: PersonTypeSelect.sql
**	Name: PersonTypeSelect
**	Desc: Selects multiple rows of PersonType Based on Id  fields 
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
		PersonType.PersonTypeID,
		PersonType.PersonTypeName,
		PersonType.Verified,
		PersonType.Inactive,
		PersonType.LastModified,
		PersonType.PersonTypeProcurmentAgency,
		PersonType.UpdatedFlag,
		PersonType.LastStatEmployeeID,
		PersonType.AuditLogTypeID
	FROM 
		dbo.PersonType 

	WHERE 
		PersonType.PersonTypeID = ISNULL(@PersonTypeID, PersonType.PersonTypeID)				
	ORDER BY 1
GO

GRANT EXEC ON PersonTypeSelect TO PUBLIC
GO
