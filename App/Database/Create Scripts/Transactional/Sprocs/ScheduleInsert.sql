

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleInsert')
	BEGIN
		PRINT 'Dropping Procedure ScheduleInsert'
		DROP Procedure ScheduleInsert
	END
GO

PRINT 'Creating Procedure ScheduleInsert'
GO
CREATE Procedure ScheduleInsert
(
	@ScheduleItemID int = null output,	
	@ScheduleGroupID int = null,	
	@ScheduleItemName nvarchar(10) = null,	
	@ScheduleItemStartDate date = null,	
	@StartTime nvarchar(5) = null,	
	@ScheduleStartDateTime datetime = null,
	@ScheduleItemEndDate	date = null,
	@EndTime nvarchar(5) = null,
	@ScheduleEndDateTime datetime = null,	
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
**	File: ScheduleInsert.sql
**	Name: ScheduleInsert
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
	INSERT [dbo].[ScheduleItem]
           ([ScheduleGroupID]
           ,[ScheduleItemName]
           ,[ScheduleItemStartDate]
           ,[ScheduleItemStartTime]
           ,[ScheduleItemEndDate]
           ,[ScheduleItemEndTime]
           ,[LastModified])
     VALUES
           (@ScheduleGroupID,
			@ScheduleItemName,
           CONVERT(DATE, @ScheduleStartDateTime),
           CONVERT(VARCHAR(5), CONVERT(TIME, @ScheduleStartDateTime, 120)),
           CONVERT(DATE, @ScheduleEndDateTime), 
           CONVERT(VARCHAR(5), CONVERT(TIME, @ScheduleEndDateTime, 120)), 
           @lastModified)
	
	SELECT @ScheduleItemID = SCOPE_IDENTITY()
	
	-- for each person not null insert the value into ScheduleItemPerson
	-- create a insertStatement
	DECLARE @insertStatement nvarchar(4000) = '	
	IF (@Person<PersonNumber> IS NOT NULL) 
	BEGIN
	
			MERGE ScheduleItemPerson AS target
			USING (SELECT @ScheduleItemID, @Person<PersonNumber>, @lastModified, <PersonNumber>) AS source (ScheduleItemID, PersonID, lastModified, Priority)
			ON (target.ScheduleItemID = source.ScheduleItemID AND target.Priority = source.Priority)
			WHEN MATCHED THEN
				UPDATE 
					SET target.PersonID = source.PersonID,
						target.LastModified = source.lastModified
					
			WHEN NOT MATCHED THEN
				INSERT
					([ScheduleItemID]
				   ,[PersonID]
				   ,[Priority]
				   ,[LastModified]) 
				   VALUES (source.ScheduleItemID, source.PersonID, source.Priority, source.LastModified);
	END
	'
	DECLARE @ParamDeclare nvarchar(4000) =
	'
		@ScheduleItemID int,
		@lastModified DATETIME,
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
	'
	DECLARE @counter Int = 1
	
	WHILE @counter < 19
	BEGIN
		 DECLARE @insertStatementTemp nvarchar(4000) = REPLACE(@insertStatement, '<PersonNumber>', @counter)
		 EXEC sp_executesql @statement = @insertStatementTemp, @params = @ParamDeclare,
		 		@ScheduleItemID = @ScheduleItemID ,
				@lastModified = @lastModified ,
				@Person1 = @Person1 ,	
				@Person2 = @Person2 ,	
				@Person3 = @Person3 ,	
				@Person4 = @Person4 ,	
				@Person5 = @Person5 ,	
				@Person6 = @Person6 ,	
				@Person7 = @Person7 ,	
				@Person8 = @Person8 ,	
				@Person9 = @Person9 ,	
				@Person10 = @Person10,	
				@Person11 = @Person11,	
				@Person12 = @Person12,	
				@Person13 = @Person13,	
				@Person14 = @Person14,	
				@Person15 = @Person15,	
				@Person16 = @Person16,	
				@Person17 = @Person17,	
				@Person18 = @Person18 
		
		SELECT @counter = @counter + 1
		
	END
	

GO



GO



GO

GRANT EXEC ON ScheduleInsert TO PUBLIC
GO
