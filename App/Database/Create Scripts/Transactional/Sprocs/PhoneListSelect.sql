

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PhoneListSelect')
	BEGIN
		PRINT 'Dropping Procedure PhoneListSelect'
		DROP Procedure PhoneListSelect
	END
GO

PRINT 'Creating Procedure PhoneListSelect'
GO
CREATE Procedure PhoneListSelect
(
		@PhoneID int = null
)
AS
/******************************************************************************
**	File: PhoneListSelect.sql
**	Name: PhoneListSelect
**	Desc: Selects multiple rows of OrganizationPhone Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/13/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/13/2011		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT 
		PhoneID AS ListId,
		Phone AS FieldValue
	FROM fn_PhoneByPhoneID(null) AS Phone
	WHERE
		Phone.Phone IS NOT NULL
	AND 
		Phone.PhoneID = COALESCE(@PhoneID, Phone.PhoneID)
	
	ORDER BY 2
GO

GRANT EXEC ON PhoneListSelect TO PUBLIC
GO
