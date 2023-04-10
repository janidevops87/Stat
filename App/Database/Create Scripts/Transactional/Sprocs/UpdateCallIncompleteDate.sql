 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'UpdateCallIncompleteDate')
	BEGIN
		PRINT 'Dropping Procedure UpdateCallIncompleteDate'
		DROP Procedure UpdateCallIncompleteDate
	END
GO

PRINT 'Creating Procedure UpdateCallIncompleteDate'
GO
CREATE Procedure UpdateCallIncompleteDate
(
		@CallID int = null output,
		@StatEmployeeID int = null,
		@LastModified datetime = null,
		@IncompleteChecked varchar(20) = null						
)
AS
/******************************************************************************
**	File: UpdateCallIncompleteDate.sql
**	Name: UpdateCallIncompleteDate
**	Desc: Updates CallIncompleteDate Based on Id field 
**	Auth: jim h
**	Date: 3/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	3/2011			jim h					Initial Sproc Creation
*******************************************************************************/
Declare @countCalls int

select @countCalls = COUNT(*) from CallIncompleteDate WHERE CallID = @CallID

if(@countCalls > 0 and @IncompleteChecked = 'False')
Begin
	UPDATE 	CallIncompleteDate 	
	SET 	CallID = @CallID,
			StatEmployeeID = @StatEmployeeID
	WHERE 	CallID = @CallID			

	DELETE 	CallIncompleteDate
	WHERE 	CallID = @CallID
End

if(@countCalls = 0 and @IncompleteChecked = 'True')
Begin
	Insert CallIncompleteDate
	(	
		CallID,
		StatEmployeeID
	)
	VALUES
		(
			@CallID,
			@StatEmployeeID
		)
end