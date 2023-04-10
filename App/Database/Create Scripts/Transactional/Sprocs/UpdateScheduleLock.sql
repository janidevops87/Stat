IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateScheduleLock')
	BEGIN
		PRINT 'Dropping Procedure: UpdateScheduleLock'
		DROP  Procedure  UpdateScheduleLock
	END

GO

PRINT 'Creating Procedure: UpdateScheduleLock'
GO
CREATE Procedure UpdateScheduleLock
	@ScheduleGroupID int, 
	@StatEmployeeID int = NULL , 
	@RemoveLock bit = NULL
		/*	(optional) input values:
				(1)  Delete lock,
				(0)	 Sets new lock if lock does not exist and retrives lock status.
					 If record is has already been locked by someone else, returns (1) */
AS

/******************************************************************************
**		File: UpdateScheduleLock.sql
**		Name: UpdateScheduleLock
**		Desc: 
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output Ordinals
**     ----------						-----------
**     see list above					0 - ScheduleGroupID
**										1 - StatEmployeeID
**										2 - LastModified
**										3 - Lock (1 = locked), (0 = not locked)
**
**		Auth: ccarroll
**		Date: 10/07/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      10/07/2008	ccarroll			initial
*******************************************************************************/
DECLARE  @intRetCode    int,
         @intRowcount   int,
         @intError      int

SELECT   @intRetCode = 0

BEGIN TRAN

/* Remove Locks older than 10 minutes */
	DELETE ScheduleLock 
	WHERE Lastmodified < DateAdd(n, -10, GetDate())
		  OR StatEmployeeID = @StatEmployeeID


IF IsNull(@RemoveLock, 0) = 0
	BEGIN
		IF (SELECT COUNT(ScheduleGroupID)  FROM ScheduleLock WHERE ScheduleGroupID = @ScheduleGroupID) > 0
			BEGIN
					SELECT	ScheduleGroupID,
							StatEmployeeID,
							LastModified,
							1 AS 'Lock'
					FROM ScheduleLock
					WHERE ScheduleGroupID = @ScheduleGroupID 
			END
		ELSE
			BEGIN
					INSERT ScheduleLock (ScheduleGroupID, StatEmployeeID) VALUES(@ScheduleGroupID, @StatEmployeeID)
					SELECT  @ScheduleGroupID AS 'ScheduleGroupID',
							@StatEmployeeID AS 'StatEmployeeID',
							GetDate() AS 'LastModified',
							0 AS 'Lock' 
			END
	END
ELSE
	BEGIN
		DELETE ScheduleLock WHERE ScheduleGroupID = @ScheduleGroupID AND StatEmployeeID = @StatEmployeeID
					SELECT  0 AS 'ScheduleGroupID',
							0 AS 'StatEmployeeID',
							GetDate() AS 'LastModified',
							0 AS 'Lock' 
		
		
	END

  --Transaction Error
  IF @@ERROR <> 0
    ROLLBACK TRANSACTION
	
  ELSE 
    COMMIT TRANSACTION
      

 SELECT @intRowCount = @@rowcount, @intError = @@error
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

RETURN @intRetCode




GO
