

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ContactCallInstructionSelect')
	BEGIN
		PRINT 'Dropping Procedure ContactCallInstructionSelect'
		DROP Procedure ContactCallInstructionSelect
	END
GO

PRINT 'Creating Procedure ContactCallInstructionSelect'
GO
CREATE Procedure ContactCallInstructionSelect
(
	@ContactCallInstructionID INT = NULL,
	@PersonID INT = NULL,
	@OrganizationID INT = NULL
)
AS
/******************************************************************************
**	File: ContactCallInstructionSelect.sql
**	Name: ContactCallInstructionSelect
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
		ContactCallInstruction.ContactCallInstructionID,
		ContactCallInstruction.SortOrder,
		ContactCallInstruction.CallInstruction,
		Person.PersonID,
		ContactCallInstruction.PersonPhoneID,
		PhoneType.PhoneTypeName + ' - ' + Phone.Phone AS AssociatedContactType ,
		ContactCallInstruction.LastModified,
		ContactCallInstruction.LastStatEmployeeID,
		ContactCallInstruction.AuditLogTypeID,
		ISNULL(ContactCallInstruction.TempCallInstructions, 0) AS TempCallInstructions
	FROM 
		dbo.ContactCallInstruction 
		
	LEFT JOIN
		PersonPhone ON PersonPhone.PersonPhoneID = ContactCallInstruction.PersonPhoneID
	JOIN
		Person ON Person.PersonID = PersonPhone.PersonID
	LEFT JOIN
		fn_PhoneByPhoneID(null) AS Phone ON Phone.PhoneID = PersonPhone.PhoneID    
		  
	LEFT JOIN		
        PhoneType ON PhoneType.PhoneTypeID = Phone.PhoneTypeID
	
	WHERE 
		PersonPhone.PersonID = ISNULL(@PersonID, PersonPhone.PersonID)
	AND
		Person.OrganizationID = ISNULL(@OrganizationID, Person.OrganizationID)
	AND
		ContactCallInstruction.ContactCallInstructionID = ISNULL(@ContactCallInstructionID, ContactCallInstruction.ContactCallInstructionID)

		
	ORDER BY 1
GO

GRANT EXEC ON ContactCallInstructionSelect TO PUBLIC
GO
