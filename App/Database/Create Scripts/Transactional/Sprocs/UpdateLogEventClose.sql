if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateLogEventClose]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
begin
	print 'drop procedure [dbo].[UpdateLogEventClose]'
	drop procedure [dbo].[UpdateLogEventClose]
end	
GO
	print 'create procedure [dbo].[UpdateLogEventClose]'
go
 
CREATE Procedure UpdateLogEventClose
    @LogEventID int, 
    @LogEventCallbackPending smallint = NULL , 
    @LastStatEmployeeID int	
AS

/******************************************************************************
**		File: 
**		Name: UpdateLogEventClose
**		Desc: Update a record into the LogEvent table
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
**		Date: 8/23/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		 8/23/07	Bret Knoll			initial
*******************************************************************************/
DECLARE    
    @LogEventName varchar(50) , 
    @LogEventPhone varchar(100) , 
    @LogEventOrg varchar(80) , 
    @LogEventDesc varchar(1000) 

	SELECT 		
		@LogEventName =  LE.LogEventName, 
		@LogEventPhone = LE.LogEventPhone, 
		@LogEventOrg = LE.LogEventOrg, 		
		@LogEventDesc = LE.LogEventDesc
	FROM 
		LogEvent LE
	WHERE 
		LE.LogEventID = @LogEventID

EXEC UpdateLogEvent  

	@LogEventID = @LogEventID,
	@LogEventName = @LogEventName, 
	@LogEventPhone = @LogEventPhone, 
	@LogEventOrg = @LogEventOrg,
	@LogEventDesc = @LogEventDesc, 
	@LogEventCallbackPending = @LogEventCallbackPending,
	@LastStatEmployeeID = 	@LastStatEmployeeID
	
Exec LogEventLockDelete
	@LogEventOrg = @LogEventOrg,
	@LogEventID = @LogEventID
	
GO
	


