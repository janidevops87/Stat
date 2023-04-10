IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'GetScheduleGroupOrganizationData')
	BEGIN
		PRINT 'Dropping Procedure GetScheduleGroupOrganizationData';
		PRINT GETDATE();
		DROP PROCEDURE GetScheduleGroupOrganizationData;
	END
GO

PRINT 'Creating Procedure GetScheduleGroupOrganizationData'
PRINT GETDATE();
GO
CREATE Procedure GetScheduleGroupOrganizationData
	@ScheduleGroupID		INT = NULL,
	@OrganizationID			INT = NULL
AS

/******************************************************************************
**		File: GetScheduleGroupOrganizationData.sql
**		Name: GetScheduleGroupOrganizationData
**		Desc: Queries the database for schedule group organization data
**
**              
**		Return values: Columns from table: Organization
** 
**		Called by:   ModStatQuery.QueryScheduleReferralOrganization
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List
**		Auth: Mike Berenson
**		Date: 3/11/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		
**		
*******************************************************************************/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	IF @ScheduleGroupID IS NOT NULL AND @OrganizationID IS NOT NULL
	BEGIN

		SELECT DISTINCT 
			Organization.OrganizationID, 
			Organization.OrganizationTypeID, 
			Organization.OrganizationName, 
			Organization.OrganizationCity, 
			State.StateAbbrv, 
			OrganizationType.OrganizationTypeName, 
			ScheduleGroupOrganization.ScheduleGroupOrganizationID 
			
		FROM 
			ScheduleGroupOrganization 
				INNER JOIN ((Organization 
				INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) 
				INNER JOIN State ON Organization.StateID = State.StateID) ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID 
				
		WHERE 
			ScheduleGroupOrganization.ScheduleGroupID = @ScheduleGroupID
			AND ScheduleGroupOrganization.OrganizationID = @OrganizationID;

	END
	ELSE IF @ScheduleGroupID IS NOT NULL
	BEGIN

		SELECT DISTINCT 
			ScheduleGroupOrganization.ScheduleGroupOrganizationID, 
			Organization.OrganizationName, 
			Organization.OrganizationCity, 
			State.StateAbbrv, 
			OrganizationType.OrganizationTypeName 
		
		FROM 
			ScheduleGroupOrganization 
				INNER JOIN ((Organization 
				INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) 
				INNER JOIN State ON Organization.StateID = State.StateID) ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID 
			
		WHERE 
			ScheduleGroupOrganization.ScheduleGroupID = @ScheduleGroupID
		
		ORDER BY 
			Organization.OrganizationName ASC;  

	END

GO

GRANT EXEC ON GetScheduleGroupOrganizationData TO PUBLIC;
GO
