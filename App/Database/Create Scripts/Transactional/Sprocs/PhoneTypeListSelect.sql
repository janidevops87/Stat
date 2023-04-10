

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PhoneTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure PhoneTypeListSelect'
		DROP Procedure PhoneTypeListSelect
	END
GO

PRINT 'Creating Procedure PhoneTypeListSelect'
GO
CREATE Procedure PhoneTypeListSelect
	@SelectAll bit = 0
AS
/******************************************************************************
**	File: PhoneTypeListSelect.sql
**	Name: PhoneTypeListSelect
**	Desc: Selects multiple rows of PhoneType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/21/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/21/2009		Bret Knoll			Initial Sproc Creation
**	6/6/2011		Bret Knoll			Modified to allow all types to be selected.
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		PhoneType.PhoneTypeID AS ListId,
		PhoneType.PhoneTypeName AS FieldValue
	FROM 
		dbo.PhoneType 
	WHERE 
		PhoneType.Inactive = CASE WHEN @SelectAll = 1 THEN PhoneType.Inactive  ELSE 0 END
	ORDER BY 2
GO

GRANT EXEC ON PhoneTypeListSelect TO PUBLIC
GO
