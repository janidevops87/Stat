SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_getScheduleLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_getScheduleLog]
GO


-- sps_GetScheduleLog '3/01/2000 00:00', '3/31/2000 23:59', 14, MT, 194 
CREATE Procedure sps_getScheduleLog

     @StartTime     smalldatetime      = null,
     @EndTime       smalldatetime      = null,
     @ScheduleGroupID         int      = null,
     @vTZ            varchar(2)        = null,
     @UserOrgID     int                = null

AS

    DECLARE @TZ          int

    EXEC spf_TZDif @vTZ, @TZ OUTPUT, @StartTime	

    SELECT @StartTime = DateAdd(hour,-@TZ,@StartTime)
    SELECT @EndTime = DateAdd(hour,-@TZ,@EndTime)     


    SELECT          DateAdd(hour, @TZ, ScheduleLogDateTime) As LogDate, 
                    PersonFirst + ' ' + PersonLast AS PersonName, 
                    OrganizationName,
                    ScheduleLogType, 
                    ScheduleLogShift, 
                    ScheduleLogChange 
     FROM           ScheduleLog
     JOIN           Person ON Person.PersonID = ScheduleLog.PersonID
     JOIN           Organization ON Organization.OrganizationID = Person.OrganizationID
     WHERE          ScheduleLogDateTime BETWEEN @StartTime AND @EndTime
     AND            ScheduleGroupID = @ScheduleGroupID
     ORDER BY ScheduleLogDateTime DESC

-- select * from person




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

