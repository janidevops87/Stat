

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AssociatedContactTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure AssociatedContactTypeListSelect'
		DROP Procedure AssociatedContactTypeListSelect
	END
GO

PRINT 'Creating Procedure AssociatedContactTypeListSelect'
GO
CREATE Procedure AssociatedContactTypeListSelect
(
		@PersonID int = null					
)
AS
/******************************************************************************
**	File: AssociatedContactTypeListSelect.sql
**	Name: AssociatedContactTypeListSelect
**	Desc: Selects multiple rows of ContactCallInstruction Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 9/18/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/18/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		PersonPhoneID AS ListId,
		Case 
			WHEN PhoneType.PhoneTypeName <> 'Email' Then
				PhoneType.PhoneTypeName + ' - ' + ISNULL(Phone.Phone, '') 
			ELSE
				PhoneType.PhoneTypeName + ' - ' + ISNULL(PersonPhone.PhoneAlphaPagerEmail, '') 
		END AS FieldValue 
	FROM 
		dbo.PersonPhone
	LEFT JOIN
		fn_PhoneByPhoneID(null) AS Phone ON Phone.PhoneID = PersonPhone.PhoneID
	LEFT JOIN		
        PhoneType ON PhoneType.PhoneTypeID = Phone.PhoneTypeID		
	WHERE 
		PersonPhone.PersonID = ISNULL(@PersonID, PersonPhone.PersonID)
	ORDER BY 2
GO

GRANT EXEC ON AssociatedContactTypeListSelect TO PUBLIC
GO
