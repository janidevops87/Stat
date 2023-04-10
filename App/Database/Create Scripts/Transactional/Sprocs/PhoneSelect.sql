

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PhoneSelect')
	BEGIN
		PRINT 'Dropping Procedure PhoneSelect'
		DROP Procedure PhoneSelect
	END
GO

PRINT 'Creating Procedure PhoneSelect'
GO
CREATE Procedure PhoneSelect
(
		@PhoneID int = null output,
		@PhoneTypeID int = null					
)
AS
/******************************************************************************
**	File: PhoneSelect.sql
**	Name: PhoneSelect
**	Desc: Selects multiple rows of Phone Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 8/7/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	8/7/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Phone.PhoneID,
		Phone.PhoneAreaCode,
		Phone.PhonePrefix,
		Phone.PhoneNumber,
		Phone.PhonePin,
		Phone.PhoneTypeID,
		PhoneTypeName AS PhoneType,
		Phone.Verified,
		Phone.Inactive,
		Phone.LastModified,
		Phone.Unused,
		Phone.UpdatedFlag,
		Phone.LastStatEmployeeID,
		Phone.AuditLogTypeID
	FROM 
		dbo.Phone 
	JOIN
		PhoneType ON PhoneType.PhoneTypeID = Phone.PhoneTypeID
		
	WHERE 
		Phone.PhoneID = ISNULL(@PhoneID, Phone.PhoneID)
	AND
		Phone.PhoneTypeID = ISNULL(@PhoneTypeID, Phone.PhoneTypeID)				
	ORDER BY 1
GO

GRANT EXEC ON PhoneSelect TO PUBLIC
GO
