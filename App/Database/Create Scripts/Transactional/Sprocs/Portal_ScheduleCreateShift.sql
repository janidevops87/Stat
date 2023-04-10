--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'Portal_ScheduleCreateShift')
	BEGIN
		PRINT 'Dropping Procedure Portal_ScheduleCreateShift'
		DROP  Procedure  Portal_ScheduleCreateShift
	END

GO

PRINT 'Creating Procedure Portal_ScheduleCreateShift'
GO

CREATE PROCEDURE Portal_ScheduleCreateShift
@ScheduleItemID INT = NULL,
@ScheduleGroupID int,
@ScheduleItemName char(10),
@ScheduleItemStartDate smalldatetime,
@ScheduleItemEndDate smalldatetime,
@TimeZone varchar(2),  
@PersonId1 INT = NULL,
@PersonId2 INT = NULL,
@PersonId3 INT = NULL,
@PersonId4 INT = NULL,
@PersonId5 INT = NULL,
@RepeatShiftEndDate DateTime = NULL,
@RepeatMonday bit = 0,
@RepeatTuesday bit = 0,
@RepeatWednesday bit = 0,
@RepeatThursday bit = 0,
@RepeatFriday bit = 0,
@RepeatSaturday bit = 0,
@RepeatSunday bit = 0,
@WebPersonId int

AS

/******************************************************************************
**	File: Portal_ScheduleCreateShift.sql
**	Name: Portal_ScheduleCreateShift
**	Desc: Called by the screen that will create/update an individual shift or
			create repeated shifts
**	Auth: plscheichenost
**	Date: 02/24/2021
**	Called By: used in reporting portal
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	02/24/2021		plscheichenost			Initial Sproc Creation
*******************************************************************************/
DECLARE
	@DateDifference INT,
	@LoopStartDate DateTime,
	@LoopEndDate DateTime;
DECLARE 
	@NewScheduleRecordsInsert Table
	(
		ScheduleItemId INT,
		StartDate DateTime,
		StartTime Varchar(5),
		EndDate DateTime,
		EndTime Varchar(5)
	);

--Entering single shift
IF (@RepeatShiftEndDate IS NULL)
BEGIN
	EXEC Portal_ScheduleInsertUpdate @ScheduleItemID, @ScheduleGroupID, @ScheduleItemName, 
	@ScheduleItemStartDate, @ScheduleItemEndDate, @TimeZone, 
	@PersonId1, @PersonId2, @PersonId3, @PersonId4, @PersonId5, @WebPersonId;
END
--repeat shifts
ELSE
BEGIN
	--convert dates for time zones
	SET  @ScheduleItemStartDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone, @ScheduleItemStartDate), @ScheduleItemStartDate)	
	SET @ScheduleItemEndDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone,@ScheduleItemEndDate),@ScheduleItemEndDate)	

	SELECT @DateDifference = DATEDIFF(mi, @ScheduleItemStartDate, @ScheduleItemEndDate);

	SET @LoopEndDate = @RepeatShiftEndDate;
	SET @LoopStartDate = @ScheduleItemStartDate
	IF (DATEDIFF(dd, @ScheduleItemStartDate, @RepeatShiftEndDate) > 90)
	BEGIN
		SET @LoopEndDate = DATEADD(dd, 90, @ScheduleItemStartDate);
	END
	
	WHILE (@LoopEndDate <= @RepeatShiftEndDate)
	BEGIN
	
		--get shifts to be created 
		;WITH cte AS (
			SELECT 1 AS DayID,
			@LoopStartDate AS FromDate,
			DATENAME(dw, @LoopStartDate) AS DayOfWeek
			UNION ALL
			SELECT cte.DayID + 1 AS DayID,
			DATEADD(d, 1 ,cte.FromDate),
			DATENAME(dw, DATEADD(d, 1 ,cte.FromDate)) AS DayOfWeek
			FROM cte
			WHERE DATEADD(d,1,cte.FromDate) <= @LoopEndDate
			AND cte.FromDate >= @LoopStartDate
			)
			INSERT INTO @NewScheduleRecordsInsert
			(StartDate,StartTime, EndDate, EndTime)
			SELECT 
				CONVERT(varchar(10), FromDate, 101),
				CONVERT(varchar(5), FromDate, 108),
				CONVERT(varchar(10), DATEADD(MI, @DateDifference, FromDate), 101),
				CONVERT(varchar(5), DATEADD(MI, @DateDifference, FromDate), 108)
			
			FROM CTE
			WHERE 
				(@RepeatMonday =1 AND  DayOfWeek = 'Monday')
			OR	(@RepeatTuesday =1 AND  DayOfWeek = 'Tuesday')
			OR	(@RepeatWednesday =1 AND  DayOfWeek = 'Wednesday')
			OR	(@RepeatThursday =1 AND  DayOfWeek = 'Thursday')
			OR	(@RepeatFriday =1 AND  DayOfWeek = 'Friday')
			OR	(@RepeatSaturday =1 AND  DayOfWeek = 'Saturday')
			OR	(@RepeatSunday =1 AND  DayOfWeek = 'Sunday');

			IF (@LoopEndDate = @RepeatShiftEndDate)
			BEGIN
				BREAK;
			END
			SET @LoopStartDate = DATEADD(dd,1, @LoopEndDate);
			SET @LoopEndDate = DATEADD(dd,90, @LoopEndDate);
			
			if (@LoopEndDate > @RepeatShiftEndDate)
			BEGIN
				SET @LoopEndDate = @RepeatShiftEndDate;
			END
		END

		INSERT INTO dbo.ScheduleItem
		(
			ScheduleGroupID,
			ScheduleItemName,
			ScheduleItemStartDate,
			ScheduleItemStartTime,
			ScheduleItemEndDate,
			ScheduleItemEndTime,
			LastModified,
			LastWebPersonID,
			AuditLogTypeID
		)
		SELECT
			@ScheduleGroupID,
			@ScheduleItemName,
			StartDate,
			StartTime,
			EndDate,
			EndTime,
			GetDate(),
			@WebPersonId,
			1
		FROM @NewScheduleRecordsInsert;

		--get scheduleitem keys
		UPDATE @NewScheduleRecordsInsert
		SET ScheduleItemId = si.ScheduleItemId
		FROM ScheduleItem si
		INNER JOIN @NewScheduleRecordsInsert i on si.ScheduleItemStartDate = i.StartDate AND si.ScheduleItemStartTime = i.StartTime AND si.ScheduleItemEndDate = i.EndDate AND si.ScheduleItemEndTime = i.EndTime
		WHERE si.scheduleGroupID = @ScheduleGroupID
		AND si.ScheduleItemName = @ScheduleItemName;

		INSERT INTO dbo.ScheduleItemPerson
		(ScheduleItemID, PersonID, Priority, LastWebPersonID, AuditLogTypeID)
		SELECT
			ScheduleItemId,
			@PersonId1,
			1,
			@WebPersonId,
			1
		FROM @NewScheduleRecordsInsert
		WHERE ScheduleItemId IS NOT NULL
		AND @PersonId1 IS NOT NULL
		union
		SELECT
			ScheduleItemId,
			@PersonId2,
			2,
			@WebPersonId,
			1
		FROM @NewScheduleRecordsInsert
		WHERE ScheduleItemId IS NOT NULL
		AND @PersonId2 IS NOT NULL
		UNION
		SELECT
			ScheduleItemId,
			@PersonId3,
			3,
			@WebPersonId,
			1
		FROM @NewScheduleRecordsInsert
		WHERE ScheduleItemId IS NOT NULL
		AND @PersonId3 IS NOT NULL
		UNION
		SELECT
			ScheduleItemId,
			@PersonId4,
			4,
			@WebPersonId,
			1
		FROM @NewScheduleRecordsInsert
		WHERE ScheduleItemId IS NOT NULL
		AND @PersonId4 IS NOT NULL
		UNION
		SELECT
			ScheduleItemId,
			@PersonId5,
			5,
			@WebPersonId,
			1
		FROM @NewScheduleRecordsInsert
		WHERE ScheduleItemId IS NOT NULL
		AND @PersonId5 IS NOT NULL;


END




GO

