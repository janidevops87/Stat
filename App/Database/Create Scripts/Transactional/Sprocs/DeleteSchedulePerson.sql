IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteSchedulePerson')
	BEGIN
		PRINT 'Dropping Procedure DeleteSchedulePerson'
		DROP  Procedure  DeleteSchedulePerson
	END

GO

PRINT 'Creating Procedure DeleteSchedulePerson'
GO

 CREATE Procedure DeleteSchedulePerson
    @ScheduleItemID int = null, 
    @Priority int = NULL  
  
	
AS

/******************************************************************************
**		File: 
**		Name: DeleteSchedulePerson
**		Desc: Delete a record into the ScheduleItemPerson table
**
**              
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     		----------						-----------
**		See List
**
**		Auth: jth
**		Date: 9/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**    		9/08			jth
**	  
*******************************************************************************/
DELETE FROM ScheduleItemPerson WHERE ScheduleItemID = @ScheduleItemID AND Priority = @Priority
GO
