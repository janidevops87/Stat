 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateLogEventPending]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
begin
	print 'drop procedure [dbo].[UpdateLogEventPending]'
	drop procedure [dbo].[UpdateLogEventPending]
end	
GO
	print 'create procedure [dbo].[UpdateLogEventPending]'
go
 
CREATE Procedure UpdateLogEventPending
    @CallID	INT, 
    @LogEventTypeID INT, 
	@UserOrgID INT,
    @CallerOrgID INT,
    @LastStatEmployeeID INT
	
AS

/******************************************************************************
**		File: 
**		Name: UpdateLogEventPending
**		Desc: lookup events and close 
**
**              
**		Return values: returns the update LogEvent record
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List
**
**		Auth: Bret Knoll
**		Date: 9/06/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		9/06/07		Bret Knoll			8.4.3.8 audit LogEvent
*******************************************************************************/
DECLARE 
	@logevents table
	(
		ID INT IDENTITY(1,1),
		LogEventID INT
	)
DECLARE
	@maxID INT,
	@loopCount INT,
	@LogEventID INT
	
INSERT 
	@logevents
SELECT
	LogEventID
FROM
	LogEvent
WHERE
	CallID = @CallID
AND
	LogeventTypeID = @LogEventTypeID
AND	(
	OrganizationID = @UserOrgID
OR
	OrganizationID = @CallerOrgID
	
	)
SELECT 
	@maxID = MAX(ID),
	@loopCount = 1
FROM
	@logevents

	
WHILE @loopCount <= @maxID
BEGIN

	SELECT 
		@LogEventID = LogEventID
	FROM 
		@logevents
	WHERE
		ID = @loopCount
	
	EXEC UpdateLogEventClose
		@LogEventID = @LogEventID, 
		@LogEventCallbackPending = 0, 
		@LastStatEmployeeID = @LastStatEmployeeID	
	
	SELECT @loopCount = @loopCount + 1

	
END	

GO
