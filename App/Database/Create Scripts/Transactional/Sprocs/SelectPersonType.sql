

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectPersonType')
	BEGIN
		PRINT 'Dropping Procedure SelectPersonType'
		PRINT GETDATE()
		DROP Procedure SelectPersonType
	END
GO

PRINT 'Creating Procedure SelectPersonType'
PRINT GETDATE()
GO
CREATE Procedure SelectPersonType
(
		@PersonTypeID int = null output					
)
AS
/******************************************************************************
**	File: SelectPersonType.sql
**	Name: SelectPersonType
**	Desc: Selects multiple rows of PersonType Based on Id  fields 
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
		PersonType.PersonTypeID,
		PersonType.PersonTypeName,
		PersonType.Verified,
		PersonType.Inactive,
		PersonType.LastModified,
		PersonType.PersonTypeProcurmentAgency,
		PersonType.UpdatedFlag
	FROM 
		dbo.PersonType 

	WHERE 
		PersonType.PersonTypeID = ISNULL(@PersonTypeID, PersonType.PersonTypeID)				

GO

GRANT EXEC ON SelectPersonType TO PUBLIC
GO
