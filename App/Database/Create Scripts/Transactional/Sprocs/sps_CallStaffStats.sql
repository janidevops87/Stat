SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CallStaffStats]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CallStaffStats]
GO


CREATE PROCEDURE sps_CallStaffStats

     @pvStartDate         datetime     = null,  
     @pvEndDate           datetime     = null,
     @pvUserOrgID	  int	       = null	 
AS
     DECLARE
     @vTZ     varchar(2),
     @TZ      int               
     


     SELECT @vTZ = TimeZone.TimeZoneAbbreviation
     FROM Organization 
     LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
     WHERE OrganizationID = 194

     EXEC spf_TZDif @vTZ, @TZ OUTPUT, @pvStartDate

     SELECT    CallTypeName, 
               PersonFirst + ' ' + PersonLast, 
               Count(CallID), 
               IsNULL(Avg(CallSeconds), 0),
               IsNULL(Max(CallSeconds), 0),
               IsNULL(Sum(CallSeconds), 0)
     FROM      Call 
     JOIN      CallType on Call.CallTypeID = CallType.CallTypeID 
     JOIN      StatEmployee on Call.StatEmployeeID = StatEmployee.StatEmployeeID 
     JOIN      Person ON Person.PersonID = StatEmployee.PersonID 
     WHERE     DATEADD(hour, @TZ, CallDateTime) Between @pvStartDate AND @pvEndDate 

     GROUP BY CallTypeName, PersonFirst + ' ' + PersonLast 
     ORDER By CallTypeName, PersonFirst + ' ' + PersonLast 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

