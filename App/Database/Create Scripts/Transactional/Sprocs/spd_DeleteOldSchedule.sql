SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

DROP PROCEDURE IF EXISTS [dbo].[spd_DeleteOldSchedule];
GO

CREATE PROCEDURE spd_DeleteOldSchedule AS

/******************************************************************************
**	File: spd_DeleteOldSchedule.sql
**	Name: spd_DeleteOldSchedule
**	Desc: Deletes Old Schedules 
**	Auth: ?
**	Date: ?
**	Called By: Delete Old Schedules (sql agent job)
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	?				?					Initial Sproc Creation
**	04/19/2021		Mike Berenson		Converted Set RowCount to Top(n) for SQL 2019 Upgrade
*******************************************************************************/

DECLARE 	
	@ScheduleLimitDate	SMALLDATETIME = DATEADD(month, -12, GETDATE()),
	@DelayTime			VARCHAR(10) = '00:00:10',
	@RowCount			INT = 1;

-- Delete old ScheduleItem records
WHILE @RowCount > 0
BEGIN
	DELETE TOP(1500) 
		ScheduleItem 
	WHERE 
		ScheduleItemStartDate < @ScheduleLimitDate
	AND   
		ScheduleItemEndDate <   @ScheduleLimitDate;

	SET @RowCount = @@ROWCOUNT;
	
	WAITFOR DELAY @DelayTime;
END

-- Delete old ScheduleLog records
WHILE @RowCount > 0
BEGIN
	DELETE TOP(1) 			
		ScheduleLog 
	WHERE
		ScheduleLogDateTime < @ScheduleLimitDate;

	SET @RowCount = @@ROWCOUNT;
	WAITFOR DELAY @DelayTime;
END
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

