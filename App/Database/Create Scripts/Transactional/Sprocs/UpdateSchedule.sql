 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateSchedule')
	BEGIN
		PRINT 'Dropping Procedure UpdateSchedule'
		DROP  Procedure  UpdateSchedule
	END

GO

PRINT 'Creating Procedure UpdateSchedule'
GO
 
 CREATE Procedure UpdateSchedule
    @ScheduleItemID int = null, 
    @NewScheduleItemID int = null, 
    @PersonID int = NULL , 
    @Priority int = NULL 
	
AS

/******************************************************************************
**		File: 
**		Name: UpdateScheduleItemPerson
**		Desc: Update a record into the ScheduleItemPerson table
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
**		Date: 8/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**    		8/08			jth
**	  
*******************************************************************************/
IF (@ScheduleItemID <> 0)
    BEGIN
    	DELETE FROM ScheduleItemPerson WHERE ScheduleItemID = @ScheduleItemID AND Priority = @Priority
    END
IF ( @NewScheduleItemID is null)
    BEGIN
      SET @NewScheduleItemID = @ScheduleItemID
    END

INSERT INTO ScheduleItemPerson (ScheduleItemID, PersonID, Priority) VALUES (@NewScheduleItemID,@PersonID,@Priority)
/*
Update 
	ScheduleItemPerson  
SET	
	PersonID = ISNULL(@PersonID, PersonID), 
	LastModified = GetDate()
			
WHERE
	ScheduleItemID = @ScheduleItemID
and	Priority = @Priority
*/
GO
