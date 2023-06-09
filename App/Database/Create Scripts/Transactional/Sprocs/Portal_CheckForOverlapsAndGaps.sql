if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Portal_CheckForOverlapsAndGaps]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Portal_CheckForOverlapsAndGaps]
GO





CREATE Procedure Portal_CheckForOverlapsAndGaps

     @OrganizationID  INT = null,
     @ScheduleGroupID INT = null,
     @StartDateTime	DateTime = null,
     @EndDateTime DateTime = null,
     @TimeZone VARCHAR(2) = null,
     @ScheduleItemId INT = null

AS
    /******************************************************************************
    **		File: Portal_CheckForOverlapsAndGaps.sql
    **		Name: Portal_CheckForOverlapsAndGaps
    **		Desc: Validate if there are any gaps/overlaps
    **
    ** 
    **		Called by:   Report Portal site
    **              
    **
    **		Auth: Pam Scheichenost
    **		Date: 03/31/2021
    *******************************************************************************
    **		Change History
    *******************************************************************************
    **		Date:		Author:				Description:
    **		--------	--------			-------------------------------------------
    **		03/31/2021	Pam Scheichenost	initial
    *******************************************************************************/


DECLARE 
        @TZ          int,
		@OverlapId	 int = 1,
		@GapId		 int = 2;
    DECLARE @Schedules TABLE(
        ScheduleItemID int,
        ScheduleGroupID int,
        ScheduleItemName varchar(10),
        ShiftStart datetime,
        ShiftEnd datetime,
		ShiftStatus int
    );
	
    DECLARE @ScheduleStatusCheck TABLE(
		ScheduleItemId_Record1 int,
		ScheduleItemId_Record2 int,
		TimeDifferenceByMinutes int
	);


    Exec spf_TZDif @TimeZone, @TZ OUTPUT, @StartDateTime;



     SELECT @StartDateTime = DateAdd(hour,-@TZ,@StartDateTime)
     SELECT @EndDateTime = DateAdd(hour,-@TZ,@EndDateTime)     

     --reset user orgid
     If @OrganizationID = 194 
          BEGIN
               SELECT @OrganizationID = OrganizationID 
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
          AND          ScheduleGroup.OrganizationID = @OrganizationID
          AND         (
                        ((ScheduleItemStartDate + ScheduleItemStartTime BETWEEN DateAdd(dd, -1, @StartDateTime) AND DateAdd(dd,1, @EndDateTime) -- getting a larger range to check for gap/overlaps for the first and last row 
						    OR
						    ScheduleItemEndDate + ScheduleItemEndTime BETWEEN DateAdd(dd, -1, @StartDateTime) AND DateAdd(dd,1, @EndDateTime)))
                        OR (@ScheduleItemId IS NOT NULL AND ScheduleItemId = @ScheduleItemId)
                       )
		  ORDER BY CAST(ScheduleItemStartDate + ScheduleItemStartTime as DateTime);

           --check if it's an edited row or new row
           IF (@ScheduleItemId IS NOT NULL)
           BEGIN
            UPDATE @Schedules
            SET ShiftStart = @StartDateTime,
                ShiftEnd = @EndDateTime
            WHERE ScheduleItemID = @ScheduleItemId;
           END
           ELSE
           BEGIN
              INSERT INTO @Schedules
              (ScheduleItemID, ScheduleGroupID, ScheduleItemName, ShiftStart, ShiftEnd, ShiftStatus)
              VALUES 
              (-1, @ScheduleGroupID, NULL, @StartDateTime, @EndDateTime, 0);
              SET @ScheduleItemId = -1;
           END;


           WITH ScheduleOrder AS
			(
				SELECT ROW_NUMBER() OVER(ORDER BY ShiftStart ASC) AS RowNum,
				*
				FROM @Schedules
			)

		  INSERT INTO @ScheduleStatusCheck
		  SELECT
			s.ScheduleItemID,
			s2.ScheduleItemID,
			DATEDIFF(mi, s.ShiftEnd, s2.ShiftStart)
		  FROM ScheduleOrder s
		  INNER JOIN ScheduleORder s2 on (s.RowNum + 1) = s2.RowNum  --give us ability to compare one row to the next row
		

		--set flag for overlaps
		UPDATE @Schedules
		SET ShiftStatus = @OverlapId
		FROM @Schedules s
		INNER JOIN @ScheduleStatusCheck ssc on s.ScheduleItemID = ssc.ScheduleItemId_Record1 OR s.ScheduleItemID = ssc.ScheduleItemId_Record2
		WHERE ssc.TimeDifferenceByMinutes < 0

		--set flag for gaps (do not set rows marked as overlap to gaps)
		UPDATE @Schedules
		SET ShiftStatus = @GapId
		FROM @Schedules s
		INNER JOIN @ScheduleStatusCheck ssc on s.ScheduleItemID = ssc.ScheduleItemId_Record1 OR s.ScheduleItemID = ssc.ScheduleItemId_Record2
		WHERE ssc.TimeDifferenceByMinutes > 0
		AND s.ShiftStatus = 0

	SELECT
		ShiftStatus
	FROM @Schedules
    WHERE ScheduleItemID = @ScheduleItemId;


GO
