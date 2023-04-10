IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'GetScheduleItemData')
	BEGIN
		PRINT 'Dropping Procedure GetScheduleItemData';
		PRINT GETDATE();
		DROP PROCEDURE GetScheduleItemData;
	END
GO

PRINT 'Creating Procedure GetScheduleItemData'
PRINT GETDATE();
GO
CREATE Procedure GetScheduleItemData
	@ScheduleGroupID		INT = NULL,
	@TimeZoneDif			INT = NULL
AS

/******************************************************************************
**		File: GetScheduleItemData.sql
**		Name: GetScheduleItemData
**		Desc: Queries the database for schedule item data
**
**              
**		Return values: Schedule item name & dates from table: ScheduleItem
** 
**		Called by:   ModStatQuery.QueryScheduleShift
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List
**		Auth: Mike Berenson
**		Date: 3/9/2020 - created from really ugly vb code
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		
**		
*******************************************************************************/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT
		ScheduleItemID,
		ScheduleGroupID,
		ScheduleItemName,
		FORMAT(DATEADD(hh, @TimeZoneDif, (ScheduleItemStartDate + ScheduleItemStartTime)), 'MM/dd/yyyy') AS 'ScheduleItemStartDate',
		FORMAT(DATEADD(hh, @TimeZoneDif, ScheduleItemStartTime), 'HH:mm')
			AS 'ScheduleItemStartTime',
		FORMAT(DATEADD(hh, @TimeZoneDif, (ScheduleItemStartDate + ScheduleItemStartTime)), 'MM/dd/yyyy HH:mm')
			AS 'ScheduleItemStartTime',
		FORMAT(DATEADD(hh, @TimeZoneDif, (ScheduleItemEndDate + ScheduleItemEndTime)), 'MM/dd/yyyy') AS 'ScheduleItemEndDate',
		FORMAT(DATEADD(hh, @TimeZoneDif, ScheduleItemEndTime), 'HH:mm')
			AS 'ScheduleItemEndTime',
		FORMAT(DATEADD(hh, @TimeZoneDif, (ScheduleItemEndDate + ScheduleItemEndTime)), 'MM/dd/yyyy HH:mm')
			AS 'ScheduleItemEndTime'
	FROM ScheduleItem
	WHERE
		ScheduleGroupID = @ScheduleGroupID
		AND (ScheduleItemStartDate + ' ' + ScheduleItemStartTime <= GETDATE()
			AND ScheduleItemEndDate + ' ' + ScheduleItemEndTime > GETDATE())
		
	ORDER BY ScheduleItemStartDate ASC;

GO

GRANT EXEC ON GetScheduleItemData TO PUBLIC;
GO
