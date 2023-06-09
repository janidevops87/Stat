
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetOrgList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
DROP PROCEDURE [dbo].[sps_GetOrgList]
	PRINT 'Dropping Procedure: sps_GetOrgList'
END
	PRINT 'Creating Procedure: sps_GetOrgList'
GO

CREATE PROCEDURE  sps_GetOrgList

	@pvWebReportGroupID 	int = 0

 AS
/******************************************************************************
**		File: sps_GetOrgList.sql
**		Name: sps_GetOrgList
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
**		11/03/2011	ccarroll	Added join to OrganizationPhone HS 29779
**		07/27/2012	ccarroll	Added note for HS 32677		
*******************************************************************************/
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

DECLARE @Main int = 60 --Constant for main SubLocation

   SELECT   	Organization.OrganizationID, 
		CASE 
		WHEN OrganizationUserCode Is Null THEN OrganizationName
		WHEN ProviderNumber Is Not Null THEN OrganizationName + ' (' + ProviderNumber + ')'
		END,
             		OrganizationAddress1, 
             		OrganizationTypeID, 
             		OrganizationAddress2, 
             		OrganizationCity, 
             		OrganizationZipCode, 
             		StateAbbrv, 
             		'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber
  FROM       	Organization 
  JOIN       	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
  JOIN       	OrganizationPhone ON OrganizationPhone.OrganizationID = Organization.OrganizationID
  
  JOIN       	State ON State.StateID = Organization.StateID
  JOIN			Phone ON Phone.PhoneID = OrganizationPhone.PhoneID   

  WHERE      	WebReportGroupID = @pvWebReportGroupID
				AND OrganizationPhone.SubLocationID = @Main
  ORDER BY   	StateAbbrv, OrganizationName 


GO