--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'Portal_ScheduleInsertUpdate')
	BEGIN
		PRINT 'Dropping Procedure Portal_ScheduleInsertUpdate'
		DROP  Procedure  Portal_ScheduleInsertUpdate
	END

GO

PRINT 'Creating Procedure Portal_ScheduleInsertUpdate'
GO

CREATE PROCEDURE Portal_ScheduleInsertUpdate
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
@WebPersonId INT


AS

/******************************************************************************
**	File: Portal_ScheduleInsertUpdate.sql
**	Name: Portal_ScheduleInsertUpdate
**	Desc: Inserts or updates a schedule Item record and corresoponding persons 
**	Auth: plscheichenost
**	Date: 02/25/2021
**	Called By: used in reporting portal
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	02/25/2021		plscheichenost			Initial Sproc Creation
*******************************************************************************/

SET  @ScheduleItemStartDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone, @ScheduleItemStartDate), @ScheduleItemStartDate)	
SET @ScheduleItemEndDate = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone,@ScheduleItemEndDate),@ScheduleItemEndDate)	


BEGIN
DECLARE
	@StartDate DATETIME,
	@StartTime varchar(5),
	@EndDate DATETIME,
	@EndTime varchar(5);

SELECT @StartDate = convert(varchar, convert(smalldatetime,  @ScheduleItemStartDate), 1);
SELECT @StartTime = convert(varchar, convert(datetime,  @ScheduleItemStartDate), 8);
SELECT @EndDate = convert(varchar, convert(smalldatetime,  @ScheduleItemEndDate), 1);
SELECT @EndTime = convert(varchar, convert(datetime, @ScheduleItemEndDate), 8);

--Insert or update values the values
IF ((SELECT COUNT(1) FROM dbo.ScheduleItem WHERE ScheduleItemID = @ScheduleItemID) = 0) OR @ScheduleItemId IS NULL 
BEGIN
	INSERT INTO ScheduleItem 
		(ScheduleGroupID,
		ScheduleItemName,
		ScheduleItemStartDate,
		ScheduleItemStartTime,
		ScheduleItemEndDate,
		ScheduleItemEndTime,
		LastModified,
		LastWebPersonID,
		AuditLogTypeID)
	VALUES 
		(@ScheduleGroupID, 
		@ScheduleItemName, 
		@StartDate,
		@StartTime,
		@EndDate,
		@EndTime,
		getdate(),
		@WebPersonId,
		1)

		--get ID inserted
		SELECT @ScheduleItemID = MAX(ScheduleItemID) 
		FROM scheduleitem;
END
ELSE
BEGIN
	UPDATE ScheduleItem
	SET ScheduleItemName = @ScheduleItemName,
		ScheduleItemStartDate = @StartDate,
		ScheduleItemStartTime = @StartTime,
		ScheduleItemEndDate = @EndDate,
		ScheduleItemEndTime = @EndTime,
		LastModified = getdate(),
		LastWebPersonID = @WebPersonId,
		AuditLogTypeID = 3
	WHERE ScheduleItemID = @ScheduleItemID;
END

--create sheduleItemPerson records
EXEC Portal_ScheduleItemPersonInsertUpdate @ScheduleItemID,  @PersonId1, 1, @WebPersonId;
EXEC Portal_ScheduleItemPersonInsertUpdate @ScheduleItemID,  @PersonId2, 2, @WebPersonId;
EXEC Portal_ScheduleItemPersonInsertUpdate @ScheduleItemID,  @PersonId3, 3, @WebPersonId;
EXEC Portal_ScheduleItemPersonInsertUpdate @ScheduleItemID,  @PersonId4, 4, @WebPersonId;
EXEC Portal_ScheduleItemPersonInsertUpdate @ScheduleItemID,  @PersonId5, 5, @WebPersonId;

END

GO

