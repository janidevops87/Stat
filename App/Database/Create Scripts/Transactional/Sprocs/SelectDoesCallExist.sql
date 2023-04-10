IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'SelectDoesCallExist')
	BEGIN
		PRINT 'Dropping Procedure SelectDoesCallExist'
		DROP Procedure SelectDoesCallExist
	END
GO

PRINT 'Creating Procedure SelectDoesCallExist'
GO
CREATE Procedure SelectDoesCallExist
(
	@CallId int,
	@CallTypeId int = null
)
AS
/******************************************************************************
**		File: SelectDoesCallExist.sql
**		Desc: Returns true if the callid exists, otherwise returns false
**		Auth: Tanvir Ather
**		Date: 02/15/2007
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		-------------------------------------------
**	01/18/2008	Tanvir Ather		Initial Sproc creation
**  5/27/11     jth					added call type id to find imports
*******************************************************************************/
if @CallTypeId = 0
Begin
	set @CallTypeID = null

Select Call.CallId 
from Call 

Where Call.CallId = @CallId 

End
if @CallTypeId > 0
Begin
	
Select Call.CallId 
from Call 
JOIN 
	Message ON Call.CallID = Message.CallID 
Where Call.CallId = @CallId 
AND
		(
			@CallTypeId IS NULL
			OR
			Call.CallTypeID = @CallTypeId
		)
End

GRANT EXEC ON SelectDoesCallExist TO PUBLIC
GO

 