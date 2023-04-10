

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleDelete')
	BEGIN
		PRINT 'Dropping Procedure ScheduleDelete'
		DROP Procedure ScheduleDelete
	END
GO

PRINT 'Creating Procedure ScheduleDelete'
GO
CREATE Procedure ScheduleDelete
(
	@ScheduleItemID int = null output,	
	@ScheduleGroupID int = null,	
	@ScheduleItemName nvarchar(10) = null,	
	@ScheduleItemStartDate date = null,	
	@StartTime nvarchar(5) = null,	
	@ScheduleStartDateTime datetime = null,
	@ScheduleItemEndDate	date = null,
	@EndTime nvarchar(5) = null,
	@SceduleEndDateTime datetime = null,	
	@Person1 int = null,	
	@Person2 int = null,	
	@Person3 int = null,	
	@Person4 int = null,	
	@Person5 int = null,	
	@Person6 int = null,	
	@Person7 int = null,	
	@Person8 int = null,	
	@Person9 int = null,	
	@Person10 int = null,	
	@Person11 int = null,	
	@Person12 int = null,	
	@Person13 int = null,	
	@Person14 int = null,	
	@Person15 int = null,	
	@Person16 int = null,	
	@Person17 int = null,	
	@Person18 int = null 
)
AS
/******************************************************************************
**	File: ScheduleDelete.sql
**	Name: ScheduleDelete
**	Desc: Inserts ScheduleItems
**	Auth: Bret Knoll
**	Date: 5/19/2011
**	Called By: Bret Knoll
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	5/19/2011		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	
	DECLARE @lastModified DATETIME = GETDATE()
	-- first insert ScheduleItem Then insert ScheduleItemPerson
	IF (COALESCE(@ScheduleItemID, 0) > 0)
	BEGIN
		DELETE [ScheduleItem] WHERE ScheduleItemID = @ScheduleItemID
		DELETE [ScheduleItemPerson] WHERE ScheduleItemID = @ScheduleItemID
	END

GO

GRANT EXEC ON ScheduleDelete TO PUBLIC
GO
