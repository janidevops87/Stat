

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ContactCallInstructionUpdate')
	BEGIN
		PRINT 'Dropping Procedure ContactCallInstructionUpdate'
		DROP Procedure ContactCallInstructionUpdate
	END
GO

PRINT 'Creating Procedure ContactCallInstructionUpdate'
GO
CREATE Procedure ContactCallInstructionUpdate
(
		@ContactCallInstructionID int = null output,
		@SortOrder tinyint = null,
		@CallInstruction varchar(100) = null,
		@PersonID INT = NULL,
		@PersonPhoneID int = null,
		@AssociatedContactType varchar(250) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@TempCallInstructions bit = null										
)
AS
/******************************************************************************
**	File: ContactCallInstructionUpdate.sql
**	Name: ContactCallInstructionUpdate
**	Desc: Updates ContactCallInstruction Based on Id field 
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

UPDATE
	dbo.ContactCallInstruction 	
SET 
		SortOrder = @SortOrder,
		CallInstruction = @CallInstruction,
		PersonPhoneID = @PersonPhoneID,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), /* 3 modified */
		TempCallInstructions = @TempCallInstructions
WHERE 
	ContactCallInstructionID = @ContactCallInstructionID 				

GO

GRANT EXEC ON ContactCallInstructionUpdate TO PUBLIC
GO
