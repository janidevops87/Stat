

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ContactCallInstructionInsert')
	BEGIN
		PRINT 'Dropping Procedure ContactCallInstructionInsert'
		DROP Procedure ContactCallInstructionInsert
	END
GO

PRINT 'Creating Procedure ContactCallInstructionInsert'
GO
CREATE Procedure ContactCallInstructionInsert
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
**	File: ContactCallInstructionInsert.sql
**	Name: ContactCallInstructionInsert
**	Desc: Inserts ContactCallInstruction Based on Id field 
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

INSERT	ContactCallInstruction
	(
		SortOrder,
		CallInstruction,
		PersonPhoneID,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID,
		TempCallInstructions
	)
VALUES
	(
		@SortOrder,
		@CallInstruction,
		@PersonPhoneID,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1), /* insert */
		@TempCallInstructions
	)

SET @ContactCallInstructionID = SCOPE_IDENTITY()

EXEC ContactCallInstructionSelect @ContactCallInstructionID

GO

GRANT EXEC ON ContactCallInstructionInsert TO PUBLIC
GO
