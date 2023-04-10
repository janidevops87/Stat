 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_ScheduleOverlap')
	BEGIN
		PRINT 'Dropping Procedure sps_ScheduleOverlap'
		DROP  Procedure  sps_ScheduleOverlap
	END

GO

PRINT 'Creating Procedure sps_ScheduleOverlap'
GO
 
 CREATE Procedure sps_ScheduleOverlap
	@ScheduleGroupID int,
	@ScheduleItemID int,
	@ScheduleItemStartDate smalldatetime,
	@ScheduleItemEndDate smalldatetime,
	@returnVal int OUTPUT,
	@TimeZone char(2) = 'MT'
	
AS

/******************************************************************************
**		File: 
**		Name: sps_ScheduleOverlap
**		Desc: Check to see if schedules you are creating overlap
**
**              
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     	----------						-----------
**		See List
**
**		Auth: jth
**		Date: 10/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**    	10/08			jth
**	    05/09			jth                     added <> same scheduleitemid
*******************************************************************************/
SET @ScheduleItemStartDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone, @ScheduleItemStartDate), @ScheduleItemStartDate)	
SET @ScheduleItemEndDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone,@ScheduleItemEndDate),@ScheduleItemEndDate)	

BEGIN
 
 SELECT  @returnVal = count(*)
    
    FROM ScheduleItem 
    WHERE ScheduleGroupID = @ScheduleGroupID and ScheduleItemID <> @ScheduleItemID and
    ((CAST(ScheduleItemStartDate + ' ' + ScheduleItemStartTime AS DateTime) > CAST(@ScheduleItemStartDate AS DateTime)  
    AND CAST(ScheduleItemStartDate + ' ' + ScheduleItemStartTime AS DateTime) < CAST(@ScheduleItemEndDate  AS DateTime)) 
    OR 
    (CAST(ScheduleItemEndDate + ' ' + ScheduleItemEndTime AS DateTime) > CAST( @ScheduleItemStartDate AS DateTime) 
    AND CAST(ScheduleItemEndDate + ' ' + ScheduleItemEndTime AS DateTime) < CAST( @ScheduleItemEndDate AS DateTime))) 
    
    RETURN @returnVal
END
GO