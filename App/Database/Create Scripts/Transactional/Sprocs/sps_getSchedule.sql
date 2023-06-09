SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_getSchedule]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_getSchedule]
GO





CREATE Procedure sps_getSchedule

     @StartTime     smalldatetime      = null,
     @EndTime       smalldatetime      = null,
     @ScheduleGroupID         int      = null,
     @vTZ            varchar(2)        = null,
     @UserOrgID     int                = null


AS

     DECLARE @MaxPriority int
     DECLARE @ForCounter  int
     DECLARE @ColumnName  varchar(10)
     DECLARE @QueryString varchar(8000)
     DECLARE @TZ          int



    Exec spf_TZDif @vTZ, @TZ OUTPUT, @StartTime



     SELECT @StartTime = DateAdd(hour,-@TZ,@StartTime)
     SELECT @EndTime = DateAdd(hour,-@TZ,@EndTime)     

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
                                       =           @ScheduleGroupID
                           AND          ScheduleGroup.OrganizationID = @UserOrgID
                           AND         (ScheduleItemStartDate + ScheduleItemStartTime BETWEEN @StartTime 
                           	     AND         @EndTime
			    OR
			    ScheduleItemEndDate + ScheduleItemEndTime BETWEEN @StartTime 
                           	     AND         @EndTime
			    )
                           

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
         SELECT @ColumnName = "Person" + convert(char(3),@ForCounter) 
         EXEC("ALTER TABLE #ScheduleTable ADD " + @ColumnName + " VARCHAR(100) NULL")
         SELECT @ForCounter = @ForCounter + 1
     END


     INSERT #ScheduleTable
          (ScheduleItemID, ScheduleGroupID, ScheduleItemName, ShiftStart, ShiftEnd)
          SELECT    ScheduleItem.ScheduleItemID,
                    ScheduleItem.ScheduleGroupID,
                    ScheduleItemName, 
                    DateAdd(hour, @TZ, ScheduleItemStartDate + ScheduleItemStartTime) AS Start,  
                    DateAdd(hour, @TZ, ScheduleItemEndDate + ScheduleItemEndTime) AS 'End'
          FROM      ScheduleItem
          LEFT JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID
          WHERE     ScheduleGroup.ScheduleGroupID = @ScheduleGroupID
          AND          ScheduleGroup.OrganizationID = @UserOrgID
           AND         (ScheduleItemStartDate + ScheduleItemStartTime BETWEEN @StartTime 
                       	 AND         @EndTime
		 OR
		 ScheduleItemEndDate + ScheduleItemEndTime BETWEEN @StartTime 
                            AND         @EndTime
		)



     -- update table with Priority person
     SELECT @ForCounter = 1
     WHILE @ForCounter <= @MaxPriority
     BEGIN
          SELECT @ColumnName = "Person" + convert(char(3),@ForCounter)
          SELECT @QueryString = "" 
          SELECT @QueryString = @QueryString + "UPDATE #ScheduleTable "
          SELECT @QueryString = @QueryString + " SET      "
          SELECT @QueryString = @QueryString + @ColumnName 
          SELECT @QueryString = @QueryString + " = PersonFirst + ' ' + PersonLast"
          SELECT @QueryString = @QueryString + " FROM     ScheduleItemPerson"
          SELECT @QueryString = @QueryString + " JOIN     Person ON Person.PersonID = ScheduleItemPerson.PersonID"
          SELECT @QueryString = @QueryString + " WHERE    Priority = "
          SELECT @QueryString = @QueryString + convert(char(3),@ForCounter)
          SELECT @QueryString = @QueryString + " AND      ScheduleItemPerson.ScheduleItemID =   #ScheduleTable.ScheduleItemID"
          
          EXEC(@QueryString)
          SELECT @ForCounter = @ForCounter + 1

     END

select * from #ScheduleTable ORDER BY ShiftStart --where Person1 is not null

DROP TABLE #ScheduleTable






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

