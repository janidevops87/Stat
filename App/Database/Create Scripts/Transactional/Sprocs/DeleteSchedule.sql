 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteSchedule')
	BEGIN
		PRINT 'Dropping Procedure DeleteSchedule'
		DROP  Procedure  DeleteSchedule
	END

GO

PRINT 'Creating Procedure DeleteSchedule'
GO
 
 CREATE Procedure DeleteSchedule
    @ScheduleItemID int = null
    
    
	
AS

/******************************************************************************
**		File: 
**		Name: DeleteSchedule
**		Desc: Removes Schedule Item and Schedule Item Person(s)...file children from schedule
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
**		Date:		Author:					Description:
**		--------		--------				-------------------------------------------
**    		9/08		jth
**	  
*******************************************************************************/
DELETE FROM ScheduleItemPerson WHERE ScheduleItemID = @ScheduleItemID 

DELETE FROM ScheduleItem WHERE ScheduleItemID = @ScheduleItemID
GO
