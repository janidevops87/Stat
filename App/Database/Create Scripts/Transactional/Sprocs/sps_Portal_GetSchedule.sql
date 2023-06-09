if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Portal_GetSchedule]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_Portal_GetSchedule]
GO





CREATE Procedure sps_Portal_GetSchedule

     @UserOrganizationID  INT = null,
     @ScheduleGroupID INT = null,
     @StartDateTime	DateTime = null,
     @EndDateTime DateTime = null,
     @TimeZone VARCHAR(2) = null

AS
    /******************************************************************************
    **		File: sps_Portal_GetSchedule.sql
    **		Name: sps_Portal_GetSchedule
    **		Desc: Returns a list of schedule shifts and people assigned to the shift
    **
    ** 
    **		Called by:   Report Portal site
    **              
    **
    **		Auth: Pam Scheichenost
    **		Date: 02/18/2021
    *******************************************************************************
    **		Change History
    *******************************************************************************
    **		Date:		Author:				Description:
    **		--------	--------			-------------------------------------------
    **		02/18/2021	Pam Scheichenost	initial
    *******************************************************************************/


DECLARE 
        @TZ          int,
		@OverlapId	 int = 1,
		@GapId		 int = 2;
    DECLARE @Schedules TABLE(
		RowId int IDENTITY(1,1),
        ScheduleItemID int,
        ScheduleGroupID int,
        ScheduleItemName varchar(10),
        ShiftStart datetime,
        ShiftEnd datetime,
        PersonId1 int,
        Person1 varchar(101),
        PersonId2 int,
        Person2 varchar(101),
        PersonId3 int,
        Person3 varchar(101),
        PersonId4 int,
        Person4 varchar(101),
        PersonId5 int,
        Person5 varchar(101),
        ShiftStatus int   --0 = row is good, 1 = overlap, 2 = gap
    );
	
    DECLARE @ScheduleStatusCheck TABLE(
		RowId_Record1 int,
		RowId_Record2 int,
		TimeDifferenceByMinutes int
	);


    Exec spf_TZDif @TimeZone, @TZ OUTPUT, @StartDateTime;



     SELECT @StartDateTime = DateAdd(hour,-@TZ,@StartDateTime)
     SELECT @EndDateTime = DateAdd(hour,-@TZ,@EndDateTime)     

     --reset user orgid
     If @UserOrganizationID = 194 
          BEGIN
               SELECT @UserOrganizationID = OrganizationID 
               FROM ScheduleGroup 
               WHERE ScheduleGroup.ScheduleGroupID = @ScheduleGroupID;
          END          

          INSERT INTO @Schedules
          (
            ScheduleItemID, 
            ScheduleGroupID, 
            ScheduleItemName, 
            ShiftStart, 
            ShiftEnd, 
			ShiftStatus
          )
          SELECT    ScheduleItem.ScheduleItemID,
                    ScheduleItem.ScheduleGroupID,
                    ScheduleItemName, 
                    DateAdd(hour, @TZ, ScheduleItemStartDate + ScheduleItemStartTime) AS ShiftStart,  
                    DateAdd(hour, @TZ, ScheduleItemEndDate + ScheduleItemEndTime) AS ShiftEnd,
					
					0
          FROM      ScheduleItem
          LEFT JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID
		  
          WHERE     ScheduleGroup.ScheduleGroupID = @ScheduleGroupID
          AND          ScheduleGroup.OrganizationID = @UserOrganizationID
          AND         (ScheduleItemStartDate + ScheduleItemStartTime BETWEEN DateAdd(dd, -1, @StartDateTime) AND DateAdd(dd,1, @EndDateTime) -- getting a larger range to check for gap/overlaps for the first and last row 
						 OR
						ScheduleItemEndDate + ScheduleItemEndTime BETWEEN DateAdd(dd, -1, @StartDateTime) AND DateAdd(dd,1, @EndDateTime))
		  ORDER BY CAST(ScheduleItemStartDate + ScheduleItemStartTime as DateTime);

        --moved person to be separate update, causing duplicate rows to be entered
        UPDATE @Schedules
        SET PersonId1 = sip1.PersonID,
			Person1 = per1.PersonFirst + ' ' + per1.PersonLast,
			PersonId2 = sip2.PersonID,
			Person2 = per2.PersonFirst + ' ' + per2.PersonLast,
			PersonId3 = sip3.PersonID,
			Person3 = per3.PersonFirst + ' ' + per3.PersonLast,
			PersonId4 = sip4.PersonID,
			Person4 = per4.PersonFirst + ' ' + per4.PersonLast,
			PersonId5 = sip5.PersonID,
            Person5 = per5.PersonFirst + ' ' + per5.PersonLast
        FROM @Schedules s
        LEFT JOIN ScheduleItemPerson sip1 ON s.ScheduleItemID = sip1.ScheduleItemID AND sip1.Priority = 1
		  LEFT JOIN Person per1 ON sip1.PersonID = per1.PersonID
		  LEFT JOIN ScheduleItemPerson sip2 ON s.ScheduleItemID = sip2.ScheduleItemID AND sip2.Priority = 2
		  LEFT JOIN Person per2 ON sip2.PersonID = per2.PersonID
		  LEFT JOIN ScheduleItemPerson sip3 ON s.ScheduleItemID = sip3.ScheduleItemID AND sip3.Priority = 3
		  LEFT JOIN Person per3 ON sip3.PersonID = per3.PersonID
		  LEFT JOIN ScheduleItemPerson sip4 ON s.ScheduleItemID = sip4.ScheduleItemID AND sip4.Priority = 4
		  LEFT JOIN Person per4 ON sip4.PersonID = per4.PersonID
		  LEFT JOIN ScheduleItemPerson sip5 ON s.ScheduleItemID = sip5.ScheduleItemID AND sip5.Priority = 5
		  LEFT JOIN Person per5 ON sip5.PersonID = per5.PersonID;

		  INSERT INTO @ScheduleStatusCheck
		  SELECT
			s.RowId,
			s2.RowId,
			DATEDIFF(mi, s.ShiftEnd, s2.ShiftStart)
		  FROM @Schedules s
		  INNER JOIN @Schedules s2 on (s.RowId + 1) = s2.RowId  --give us ability to compare one row to the next row
		

		--set flag for overlaps
		UPDATE @Schedules
		SET ShiftStatus = @OverlapId
		FROM @Schedules s
		INNER JOIN @ScheduleStatusCheck ssc on s.RowId = ssc.RowId_Record1 OR s.RowId = ssc.RowId_Record2
		WHERE ssc.TimeDifferenceByMinutes < 0

		--set flag for gaps (do not set rows marked as overlap to gaps)
		UPDATE @Schedules
		SET ShiftStatus = @GapId
		FROM @Schedules s
		INNER JOIN @ScheduleStatusCheck ssc on s.RowId = ssc.RowId_Record1 OR s.RowId = ssc.RowId_Record2
		WHERE ssc.TimeDifferenceByMinutes > 0
		AND s.ShiftStatus = 0

	SELECT
		ScheduleItemID ,
		ScheduleGroupID,
		ScheduleItemName,
		ShiftStart,
		ShiftEnd,
		PersonId1,
		Person1,
		PersonId2,
		Person2,
		PersonId3,
		Person3,
		PersonId4,
		Person4,
		PersonId5,
		Person5,
		ShiftStatus
	FROM @Schedules
    WHERE (ShiftStart BETWEEN @StartDateTime AND @EndDateTime -- filtering out additional rows retrieved for overlap/gap checks
		 OR
		ShiftEnd BETWEEN @StartDateTime AND @EndDateTime)
	ORDER BY ShiftStart;


GO
