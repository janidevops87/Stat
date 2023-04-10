 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleLogInsert')
	BEGIN
		PRINT 'Dropping Procedure ScheduleLogInsert'
		DROP Procedure ScheduleLogInsert
	END
GO

PRINT 'Creating Procedure ScheduleLogInsert'
GO
CREATE Procedure ScheduleLogInsert
(
	@ScheduleLogID	int= null output,
	@ScheduleGroupID int = null,	
	@ScheduleLogDateTime smalldatetime = null,
	@StatEmployeeID int = null,	
	@ScheduleLogType varchar(20) = null,
	@ScheduleLogShift varchar(80) = null, 
	@ScheduleLogChange varchar(200) = null,
	@LastModified datetime = null,
	@PersonID int = null
	
)
AS
/******************************************************************************
**	File: ScheduleLogInsert.sql
**	Name: ScheduleLogInsert
**	Desc: Inserts ScheduleLogItems
**	Auth: Bret Knoll
**	Date: 5/19/2011
**	Called By: Bret Knoll
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/20/2011		Bret Knoll			Initial Sproc Creation
*******************************************************************************/

SELECT 
	@PersonID = PersonID 
FROM 
	StatEmployee 
WHERE 
	StatEmployeeID = @StatEmployeeID

	INSERT [ScheduleLog]
           ([ScheduleGroupID]
           ,[ScheduleLogDateTime]
           ,[PersonID]
           ,[ScheduleLogType]
           ,[ScheduleLogShift]
           ,[ScheduleLogChange]
           ,[LastModified])
     VALUES
           (
           @ScheduleGroupID,
           @ScheduleLogDateTime,
           @PersonID,
           @ScheduleLogType,
           @ScheduleLogShift, 
           @ScheduleLogChange,
           @LastModified
           )
	
	SELECT @ScheduleLogID = SCOPE_IDENTITY()
	
	

	SELECT 
		[ScheduleLogID]
      ,[ScheduleGroupID]
      ,[ScheduleLogDateTime]
      ,[PersonID]
      ,[ScheduleLogType]
      ,[ScheduleLogShift]
      ,[ScheduleLogChange]
      ,[LastModified]
	FROM 
		[ScheduleLog]
	WHERE 
		[ScheduleLogID] = @ScheduleLogID
GO



GO

GRANT EXEC ON ScheduleLogInsert TO PUBLIC
GO
