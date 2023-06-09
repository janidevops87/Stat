SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_ScheduleItemPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_ScheduleItemPerson]
GO



CREATE PROCEDURE  spd_ScheduleItemPerson
	
	@vScheduleItemID		int	= null,
	@vUserOrgID			int	= null,
        @vPriority                      int     = null

 AS

    If @vUserOrgID = 194 
          BEGIN
               SELECT DISTINCT      @vUserOrgID = OrganizationID 
               FROM                 Scheduleitemperson 
               JOIN                 ScheduleItem ON ScheduleItem.ScheduleItemID = ScheduleItemPerson.ScheduleItemID
               JOIN                 ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID
               WHERE                Scheduleitemperson.ScheduleItemID = @vScheduleItemID    
          END          



     DELETE ScheduleItemPerson
     
     FROM      ScheduleItemPerson 
     JOIN      ScheduleItem ON ScheduleItem.ScheduleItemID = ScheduleItemPerson.ScheduleItemID
     JOIN      ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID
     WHERE     ScheduleItemPerson.ScheduleItemID 
               = @vScheduleItemID 
     AND       Priority 
               = @vPriority
     AND       ScheduleGroup.OrganizationID = @vUserOrgID






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

