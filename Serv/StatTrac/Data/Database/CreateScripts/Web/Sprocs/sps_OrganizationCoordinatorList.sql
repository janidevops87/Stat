 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OrganizationCoordinatorList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure sps_OrganizationCoordinatorList'
	drop procedure [dbo].[sps_OrganizationCoordinatorList]
END
GO
PRINT 'Creating Procedure sps_OrganizationCoordinatorList'
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sps_OrganizationCoordinatorList
	@UserOrgID INT = NULL,
	@webReportGroupID INT = NULL,
	@coordinatorOrganizationID INT = NULL -- this is not used and does not make since.
/******************************************************************************
**		File: sps_OrganizationCoordinatorList.sql
**		Name: sps_OrganizationCoordinatorList
**		Desc: get list of coordinators based on report group or user's organization
**
** 
**		Called by:   
**              
**
**		Auth: Bret Knoll
**		Date: 2/22/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		2/22/2008	Bret Knoll			initial
**		1/14/2009	Bret Knoll			Modified to handle report group and user's organization 
**										removed query for referral facility organization
*******************************************************************************/

AS

SET NOCOUNT ON


SELECT
	s.StatEmployeeID, 
	s.StatEmployeeLastName + ', ' + s.StatEmployeeFirstName 'CoordinatorName'
FROM
	Statemployee s
JOIN	
	Person p ON p.PersonID = s.PersonID
WHERE
	p.Inactive = 0
AND
	(
		p.OrganizationID = ISNULL(@UserOrgID, p.OrganizationID)	
		OR
		p.OrganizationID IN 
			(
			SELECT 
				OrgHierarchyParentID
			FROM
				WebReportGroup
			WHERE
				( 
					WebReportGroupID = @webReportGroupID
				or
					OrgHierarchyParentID = @UserOrgID
				)
			)
	)
ORDER BY
	s.StatEmployeeLastName, 
	s.StatEmployeeFirstName	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

