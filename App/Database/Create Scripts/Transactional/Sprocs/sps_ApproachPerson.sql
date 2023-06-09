SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApproachPerson]
GO


/****** Object:  Stored Procedure dbo.sps_Person    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_ApproachPerson

		@vOrgID	int		= null,
		@vPersonID	int		= null,
		@vActiveStatus	int		= null

AS

IF @vPersonID is null
   Begin
	IF @vActiveStatus = 0
		
		/*  Get all active and inactive  */

		SELECT	 PersonID, PersonFirst, PersonLast
		FROM	 Person
		WHERE 	 OrganizationID = @vOrgID

                UNION
                  
                SELECT PersonID, PersonFirst, PersonLast
	        FROM   Criteria
	        JOIN   CriteriaOrganization ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
	        JOIN   CriteriaScheduleGroup ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID 
	        JOIN   ScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID
	        JOIN   ScheduleGroupOrganization ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
	        JOIN   Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID
                JOIN   Person ON   Organization.OrganizationID = Person.OrganizationID
	        WHERE  CriteriaOrganization.OrganizationID = @vOrgID
	        AND    ScheduleGroupOrganization.OrganizationID = @vOrgID
		ORDER BY PersonFirst

	IF @vActiveStatus = 1

		/*  Get only active  */

		SELECT	PersonID, PersonFirst, PersonLast
		FROM	Person
		WHERE 	OrganizationID = @vOrgID
		AND	Inactive <> 1

                UNION

                SELECT PersonID, PersonFirst, PersonLast
	        FROM   Criteria
	        JOIN   CriteriaOrganization ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
	        JOIN   CriteriaScheduleGroup ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID 
	        JOIN   ScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID
	        JOIN   ScheduleGroupOrganization ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
	        JOIN   Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID
                JOIN   Person ON   Organization.OrganizationID = Person.OrganizationID
	        WHERE  CriteriaOrganization.OrganizationID = @vOrgID
	        AND    ScheduleGroupOrganization.OrganizationID = @vOrgID
                AND    Person.Inactive <> 1  
		ORDER BY PersonFirst

	IF @vActiveStatus = 2

		/*  Get only inactive  */

		SELECT	PersonID, PersonFirst, PersonLast
		FROM	Person
		WHERE 	OrganizationID = @vOrgID
		AND	Inactive = 1

                UNION

                SELECT PersonID, PersonFirst, PersonLast
	        FROM   Criteria
	        JOIN   CriteriaOrganization ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
	        JOIN   CriteriaScheduleGroup ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID 
	        JOIN   ScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID
	        JOIN   ScheduleGroupOrganization ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
	        JOIN   Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID
                JOIN   Person ON   Organization.OrganizationID = Person.OrganizationID
	        WHERE  CriteriaOrganization.OrganizationID = @vOrgID
	        AND    ScheduleGroupOrganization.OrganizationID = @vOrgID
                AND    Person.Inactive = 1  
		ORDER BY	PersonFirst
   End
ELSE
   Begin
	SELECT	PersonID, PersonFirst, PersonLast
	FROM		Person
	WHERE 	PersonID = @vPersonID
   End




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

