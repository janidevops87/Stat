IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetScheduleSingle')
	BEGIN
		PRINT 'Dropping Procedure GetScheduleSingle'
		DROP  Procedure  GetScheduleSingle
	END

GO

PRINT 'Creating Procedure GetScheduleSingle'
GO
CREATE Procedure GetScheduleSingle
    
     @ScheduleGroupID         int      = null,
     @ScheduleItemID         int      = null,
     @TZ          varchar(2),
     @UserOrgID     int                = null
AS

/******************************************************************************
**		File: 
**		Name: GetLogEventList
**		Desc: Obtains the list of LogEvents
**
**              
**		Return values:
** 
**		Called by:   
**		 StatTrac.ModStatQuery.QueryOpenLogEvent
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: jth
**		Date: 9/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		Initial
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

  DECLARE @MaxPriority int
     DECLARE @ForCounter  int
     DECLARE @ColumnName  varchar(10)
     DECLARE @QueryString varchar(8000)
     DECLARE  @iTZ          int	
   
Exec spf_TZDif @TZ, @iTZ OUTPUT, '01/01/08'
   
     --reset user orgid
     If @UserOrgID = 194 
          BEGIN
               SELECT @UserOrgID = OrganizationID 
               FROM ScheduleGroup 
               WHERE ScheduleGroup.ScheduleGroupID 
                     =           @ScheduleGroupID 
     
          END          

     -- Get MaxPriority to determine number or priority columns.
     SELECT @MaxPriority = MAX(Priority)
                           FROM        ScheduleItemPerson
                           JOIN        ScheduleItem ON ScheduleItem.ScheduleItemID  = ScheduleItemPerson.ScheduleItemID 
                           JOIN        ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID
                           JOIN        Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID
                           WHERE       ScheduleGroup.ScheduleGroupID 
                                       =           @ScheduleGroupID and ScheduleItem.ScheduleItemID = @ScheduleItemID
                           AND          ScheduleGroup.OrganizationID = @UserOrgID
                          
                           

     -- Build ScheduleTable
     CREATE TABLE #ScheduleTable
     (
          ScheduleItemID        int,
          ScheduleGroupID       int,
          ScheduleItemName      varchar(10),
          ShiftStart            smalldatetime,
          ShiftEnd              smalldatetime
          
     )

     -- Add Priority Columns to Table
     SELECT @ForCounter = 1
     WHILE @ForCounter <= @MaxPriority
     BEGIN
         SELECT @ColumnName = 'Person' + convert(char(3),@ForCounter) 
         EXEC('ALTER TABLE #ScheduleTable ADD ' + @ColumnName + ' VARCHAR(100) NULL')
         SELECT @ColumnName = 'PersonID' + convert(char(3),@ForCounter) 
         EXEC('ALTER TABLE #ScheduleTable ADD ' + @ColumnName + '  VARCHAR(100) NULL')
         SELECT @ForCounter = @ForCounter + 1
     END


     INSERT #ScheduleTable
          (ScheduleItemID, ScheduleGroupID, ScheduleItemName, ShiftStart, ShiftEnd)
          SELECT    ScheduleItem.ScheduleItemID,
                    ScheduleItem.ScheduleGroupID,
                    ScheduleItemName, 
                    DateAdd(hour, @iTZ, ScheduleItemStartDate + ScheduleItemStartTime) AS Start,  
                    DateAdd(hour, @iTZ, ScheduleItemEndDate + ScheduleItemEndTime) AS 'End'
          FROM      ScheduleItem
          LEFT JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID
          WHERE     ScheduleGroup.ScheduleGroupID = @ScheduleGroupID and ScheduleItem.ScheduleItemID = @ScheduleItemID
          AND          ScheduleGroup.OrganizationID = @UserOrgID
          



     -- update table with Priority person
     SELECT @ForCounter = 1
     WHILE @ForCounter <= @MaxPriority
     BEGIN
          SELECT @ColumnName = 'Person' + convert(char(3),@ForCounter)
          SELECT @QueryString = '' 
          SELECT @QueryString = @QueryString + 'UPDATE #ScheduleTable '
          SELECT @QueryString = @QueryString + ' SET      '
          SELECT @QueryString = @QueryString + @ColumnName 
          SELECT @QueryString = @QueryString + ' = PersonFirst + '' '' + PersonLast'
          SELECT @QueryString = @QueryString + ' FROM     ScheduleItemPerson'
          SELECT @QueryString = @QueryString + ' JOIN     Person ON Person.PersonID = ScheduleItemPerson.PersonID'
          SELECT @QueryString = @QueryString + ' WHERE    Priority = '
          SELECT @QueryString = @QueryString + convert(char(3),@ForCounter)
          SELECT @QueryString = @QueryString + ' AND      ScheduleItemPerson.ScheduleItemID =   #ScheduleTable.ScheduleItemID'
          
          EXEC(@QueryString)
          SELECT @ForCounter = @ForCounter + 1

     END
     
      -- update table with Priority personid
     SELECT @ForCounter = 1
     WHILE @ForCounter <= @MaxPriority
     BEGIN
          SELECT @ColumnName = 'PersonID' + convert(char(3),@ForCounter)
          SELECT @QueryString = '' 
          SELECT @QueryString = @QueryString + 'UPDATE #ScheduleTable '
          SELECT @QueryString = @QueryString + ' SET      '
          SELECT @QueryString = @QueryString + @ColumnName 
          SELECT @QueryString = @QueryString + ' = Person.PersonID'
          SELECT @QueryString = @QueryString + ' FROM     ScheduleItemPerson'
          SELECT @QueryString = @QueryString + ' JOIN     Person ON Person.PersonID = ScheduleItemPerson.PersonID'
          SELECT @QueryString = @QueryString + ' WHERE    Priority = '
          SELECT @QueryString = @QueryString + convert(char(3),@ForCounter)
          SELECT @QueryString = @QueryString + ' AND      ScheduleItemPerson.ScheduleItemID =   #ScheduleTable.ScheduleItemID'
          
          EXEC(@QueryString)
          SELECT @ForCounter = @ForCounter + 1
	END

select * from #ScheduleTable ORDER BY ShiftStart --where Person1 is not null

DROP TABLE #ScheduleTable
GO

 