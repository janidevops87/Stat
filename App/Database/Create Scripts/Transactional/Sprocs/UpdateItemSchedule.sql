 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateItemSchedule')
	BEGIN
		PRINT 'Dropping Procedure UpdateItemSchedule'
		DROP  Procedure  UpdateItemSchedule
	END

GO

PRINT 'Creating Procedure UpdateItemSchedule'
GO
 
 CREATE Procedure UpdateItemSchedule
    @ScheduleItemID int = NULL , 
    @ScheduleItemName varchar(10) = NULL , 
    @ScheduleItemStartDate VARCHAR(50) = NULL , 
    @ScheduleItemEndDate smalldatetime = NULL,
    @TimeZone varchar(2) 
    
AS

/******************************************************************************
**		File: UpdateUpdateItemSchedule.sql
**		Name: UpdateItemSchedule
**		Desc: 
**
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See list.
**
**		Auth: jth
**		Date: 10/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**     
*******************************************************************************/
SET  @ScheduleItemStartDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone, @ScheduleItemStartDate), @ScheduleItemStartDate)	
SET @ScheduleItemEndDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone,@ScheduleItemEndDate),@ScheduleItemEndDate)	

DECLARE @StartDate DATETIME
DECLARE @StartTime varchar(5)
DECLARE @EndDate DATETIME
DECLARE @EndTime varchar(5)

SELECT @StartDate = convert(varchar, convert(smalldatetime,  @ScheduleItemStartDate), 1)
SELECT @StartTime = convert(varchar, convert(datetime,  @ScheduleItemStartDate), 8)
SELECT @EndDate = convert(varchar, convert(smalldatetime,  @ScheduleItemEndDate), 1)
SELECT @EndTime = convert(varchar, convert(datetime, @ScheduleItemEndDate), 8)

UPDATE
	ScheduleItem
SET
    
    ScheduleItemName  = @ScheduleItemName , 
    ScheduleItemStartDate = @StartDate , 
    ScheduleItemStartTime = @StartTime , 
    ScheduleItemEndDate = @EndDate , 
    ScheduleItemEndTime = @EndTime,
	LastModified = GetDate()
	
WHERE
	ScheduleItemID = @ScheduleItemID
GO

