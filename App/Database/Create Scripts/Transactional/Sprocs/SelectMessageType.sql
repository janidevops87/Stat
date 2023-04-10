

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectMessageType')
	BEGIN
		PRINT 'Dropping Procedure SelectMessageType'
		PRINT GETDATE()
		DROP Procedure SelectMessageType
	END
GO

PRINT 'Creating Procedure SelectMessageType'
PRINT GETDATE()
GO
CREATE Procedure SelectMessageType
(
		@MessageTypeID int = null output					
)
AS
/******************************************************************************
**	File: SelectMessageType.sql
**	Name: SelectMessageType
**	Desc: Selects multiple rows of MessageType Based on Id  fields 
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
		MessageType.MessageTypeID,
		MessageType.MessageTypeName,
		MessageType.Verified,
		MessageType.Inactive,
		MessageType.LastModified,
		MessageType.UpdatedFlag
	FROM 
		dbo.MessageType 

	WHERE 
		MessageType.MessageTypeID = ISNULL(@MessageTypeID, MessageType.MessageTypeID)				

GO

GRANT EXEC ON SelectMessageType TO PUBLIC
GO
