--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertScheduleItem')
	BEGIN
		PRINT 'Dropping Procedure InsertScheduleItem'
		DROP  Procedure  InsertScheduleItem
	END

GO

PRINT 'Creating Procedure InsertScheduleItem'
GO

CREATE PROCEDURE InsertScheduleItem

@ScheduleGroupID int,
@ScheduleItemName char(10),
@ScheduleItemStartDate smalldatetime,
@ScheduleItemEndDate smalldatetime,
@returnVal int OUTPUT,
@TimeZone varchar(2) 


AS

SET  @ScheduleItemStartDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone, @ScheduleItemStartDate), @ScheduleItemStartDate)	
SET @ScheduleItemEndDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone,@ScheduleItemEndDate),@ScheduleItemEndDate)	


BEGIN

DECLARE @StartDate DATETIME
DECLARE @StartTime varchar(5)
DECLARE @EndDate DATETIME
DECLARE @EndTime varchar(5)

SELECT @StartDate = convert(varchar, convert(smalldatetime,  @ScheduleItemStartDate), 1)
SELECT @StartTime = convert(varchar, convert(datetime,  @ScheduleItemStartDate), 8)
SELECT @EndDate = convert(varchar, convert(smalldatetime,  @ScheduleItemEndDate), 1)
SELECT @EndTime = convert(varchar, convert(datetime, @ScheduleItemEndDate), 8)

--Insert the values

INSERT INTO ScheduleItem 
(
	ScheduleGroupID,
	ScheduleItemName,
	ScheduleItemStartDate,
	ScheduleItemStartTime,
	ScheduleItemEndDate,
	ScheduleItemEndTime,
	LastModified
)
VALUES 
(@ScheduleGroupID, 
@ScheduleItemName, 
@StartDate,
@StartTime,
@EndDate,
@EndTime,
getdate())



--Select the column to send back


SELECT @returnVal = MAX(ScheduleItemID) FROM scheduleitem



--Return Value


RETURN @returnVal


END

GO
