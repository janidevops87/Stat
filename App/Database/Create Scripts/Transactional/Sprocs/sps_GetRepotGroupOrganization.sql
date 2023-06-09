
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetReportGroupOrganization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
DROP PROCEDURE [dbo].[sps_GetReportGroupOrganization]
	PRINT 'Dropping Procedure: sps_GetReportGroupOrganization'
END
	PRINT 'Creating Procedure: sps_GetReportGroupOrganization'
GO

CREATE PROCEDURE  sps_GetReportGroupOrganization

	@pvWebReportGroupID 	int = 0

 AS
/******************************************************************************
**		File: sps_GetReportGroupOrganization.sql
**		Name: sps_GetReportGroupOrganization
**		Desc: Gets Organization data
**              
**		Return values:
** 
**		Called by:   Reporting
**              
**		Auth: ccarroll		
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		09/20/2012	ccarroll	HS 32677 Initial		
*******************************************************************************/
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 


  SELECT Organization.OrganizationId, 
		 Organization.OrganizationName,
		 Organization.OrganizationAddress1,
		 Organization.OrganizationTypeId,
		 Organization.OrganizationAddress2,
		 Organization.OrganizationCity,
		 Organization.OrganizationZipCode,
		 State.StateAbbrv


		 FROM WebReportGroup
		 JOIN WebReportGroupOrg ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID
		 INNER JOIN ((Organization INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID)
		 INNER JOIN State ON Organization.StateID = State.StateID) ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
		 WHERE WebReportGroup.WebReportGroupID = @pvWebReportGroupID
  
  ORDER BY Organization.OrganizationName ASC





GO