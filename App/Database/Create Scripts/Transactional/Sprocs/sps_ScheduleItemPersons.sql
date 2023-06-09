SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ScheduleItemPersons]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ScheduleItemPersons]
GO



-- sps_ScheduleItemPersons, @vScheduleItemID, @vUserOrgID,@vTZ
CREATE PROCEDURE  sps_ScheduleItemPersons
	
	@vScheduleItemID	  int	        = null,
	@vUserOrgID		  int     	= null,
       	 @vTZ                      varchar(2)    = null

 AS

  DECLARE @TZ          int

  Exec spf_TZDif @vTZ, @TZ OUTPUT
 
           --reset user orgid
     If @vUserOrgID = 194 
          BEGIN
               SELECT DISTINCT      @vUserOrgID = OrganizationID 
               FROM                 Scheduleitemperson 
               JOIN                 ScheduleItem ON ScheduleItem.ScheduleItemID = ScheduleItemPerson.ScheduleItemID
               JOIN                 ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID
               WHERE                Scheduleitemperson.ScheduleItemID = @vScheduleItemID    
          END          
 

	SELECT 
       			OrganizationName,
       			ScheduleGroupName,
       			ScheduleItemPerson.PersonID,
       			ScheduleItem.ScheduleItemID,
       			Case When Priority Is Null Then 0 Else Priority END AS 'Priority',
       			ScheduleItem.ScheduleGroupID, 
       			ScheduleItem.ScheduleItemName, 
                        DateAdd(hour, @TZ, ScheduleItemStartDate + ScheduleItemStartTime) AS Start,  
                        DateAdd(hour, @TZ, ScheduleItemEndDate + ScheduleItemEndTime) AS 'End',
       			PersonFirst,
       			PersonLast

	FROM 		ScheduleItem 
	LEFT JOIN 	ScheduleItemPerson ON ScheduleItemPerson.ScheduleItemID = ScheduleItem.ScheduleItemID
	LEFT JOIN 	Person ON Person.PersonID = ScheduleItemPerson.PersonID
	LEFT JOIN 	ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID
	LEFT JOIN 	Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID
	WHERE 	        ScheduleItem.ScheduleItemID = @vScheduleItemID
	AND   		ScheduleGroup.OrganizationID =   @vUserOrgID
	Order By 	Priority
       
/*     
	FROM 		ScheduleItemPerson
	JOIN 		ScheduleItem ON ScheduleItem.ScheduleItemID = ScheduleItemPerson.ScheduleItemID
	JOIN 		Person ON Person.PersonID = ScheduleItemPerson.PersonID
	JOIN 		ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID
	JOIN 		Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID
	WHERE 	 ScheduleItemPerson.ScheduleItemID = @vScheduleItemID
	AND   		ScheduleGroup.OrganizationID =   @vUserOrgID
	Order By 	Priority
*/




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

