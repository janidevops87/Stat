SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ScheduleGroupName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ScheduleGroupName]
GO




Create Procedure sps_ScheduleGroupName

     @ScheduleGroupID int = null

AS 




SELECT    ScheduleGroupName, OrganizationName 
FROM      ScheduleGroup
JOIN      Organization on Organization.OrganizationID = ScheduleGroup.OrganizationID
WHERE     ScheduleGroupID = @ScheduleGroupID

-- sps_ScheduleGroupName 1
-- select * from schedulegroup


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

