SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineScheduleAccessList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineScheduleAccessList]
GO



-- SPS_OnlineScheduleAccessList 7

Create Procedure sps_OnlineScheduleAccessList
     
     @vOrganizationID          AS     int =null,
     @vAccessSetting           AS     varchar(25)=null
AS

-- If AllowInternetScheduleAccess is 0 or null access is not allowed.  If it is 1 access is allowed.
-- check to see if a 1 is passed for @vAccessSTring if so query only for people with access else query for null and 0 values

IF @vAccessSetting = -1 

BEGIN

     SELECT     PersonID, 
                PersonFirst + ' ' + PersonLast AS PersonName,
                Case 
                    when AllowInternetScheduleAccess is null then 0
                    else AllowInternetScheduleAccess 
                End AS 'AllowInternetScheduleAccess'
     FROM       Person 
     Where      OrganizationID = @vOrganizationID

     AND        AllowInternetScheduleAccess = -1
     AND        Inactive = 0
     Order By PersonLast, PersonFirst

END
ELSE
BEGIN

     SELECT     PersonID, 
                PersonFirst + ' ' + PersonLast AS PersonName,
                Case 
                    when AllowInternetScheduleAccess is null then 0
                    else AllowInternetScheduleAccess 
                End AS 'AllowInternetScheduleAccess'
     FROM       Person 
     Where      OrganizationID = @vOrganizationID
     AND        Inactive = 0
     AND        (AllowInternetScheduleAccess is null
                 OR   AllowInternetScheduleAccess = 0)

     Order By PersonLast, PersonFirst
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

