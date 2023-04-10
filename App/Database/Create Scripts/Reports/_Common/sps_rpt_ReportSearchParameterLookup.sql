IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReportSearchParameterLookup')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReportSearchParameterLookup';
		DROP  Procedure  sps_rpt_ReportSearchParameterLookup;
	END

GO

PRINT 'Creating Procedure sps_rpt_ReportSearchParameterLookup';
GO
CREATE Procedure sps_rpt_ReportSearchParameterLookup
	@StatEmployeeID AS Int = Null,
	@ReportGroupID AS Int = Null,
	@OrganizationID AS Int = Null,
	@UserOrgID AS Int = Null,
	@PersonID AS Int = Null,
	@CoordinatorID AS Int = Null,
	@TrackingTypeID As Int = Null,
	@OrganizationTypeID As INT = Null
AS

/******************************************************************************
**		File: sps_rpt_ReportSearchParameterLookup.sql
**		Name: sps_rpt_ReportSearchParameterLookup
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   Reporting Services
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: Christopher Carroll 
**		Date: 07/12/2007
**
**		Notes: If null values are passed as input, 'N/A' will be returned in the result set
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------		-------------------------------------------
**    07/12/2007		ccarroll		initial release
**	  07/13/2007		ccarroll		changed ApproachPersonID to StatEmployeeID
**    08/31/2007		ccarroll		added StatTrac Versoning
**    2/08/2008			jth				added reportgrouptitle
**	  04/25/2008		ccarroll		Updated StatTrac version to 8.4.5
**	  06/12/2008		ccarroll		Added Person name lookup for Approach person
**	  09/05/2008		ccarroll		Updated StatTrac version to 8.4.6
**	  12/04/2008		ccarroll		Updated StatTrac verson to 8.4.7
**										Added StatEmployeeID to @CoordinatorID
**	  12/20/2010		ccarroll		Changed StatTrac version to 9.0.0.140
**	  07/29/2011		ccarroll		Changed StatTrac version to 9.1.0.212
**	  10/28/2011		ccarroll		Changed StatTrac version to 9.2.0 for CCRST151 release
**	  01/13/2011		ccarroll		Changed StatTrac version to 9.2.5 for CCRST165 release
**    3/08/2012			jth				added tracking type name
**    5/6/2013			jth				made tracking type id nullable
*******************************************************************************/
DECLARE
	@StatEmployeeName AS varchar(100),
 	@ReportGroupName AS varchar(100),
	@OrganizationName AS varchar(100),
	@UserOrgName AS varchar(100),
	@ReportGroupTitle AS varchar(100),
	@PersonName AS varchar(100),
	@CoordinatorName AS varchar(100),
	@TrackingTypeName AS varchar(100),
	@OrganizationTypeName AS varchar(100);

	/* Person Lookup By StatEmployeeID*/
	SET @StatEmployeeName = 
		(SELECT Person.PersonFirst + ' ' + Person.PersonLast
		FROM Person
		JOIN StatEmployee ON StatEmployee.PersonID = Person.PersonID 
		WHERE StatEmployeeID = @StatEmployeeID);

	/* Report Group Lookup */
	SET @ReportGroupName = 
		(SELECT WebReportGroupName
		FROM WebReportGroup
		WHERE WebReportGroupID = @ReportGroupID);

	/* Organization Lookup */
	SET @OrganizationName = 
		(SELECT OrganizationName
		FROM Organization
		WHERE OrganizationID = @OrganizationID);

	/* User Org Lookup */
	SET @UserOrgName = 
		(SELECT OrganizationName
		FROM Organization
		WHERE OrganizationID = @UserOrgID);

	/* User Report Title Lookup */
	SET @ReportGroupTitle = 
		(SELECT DISTINCT  OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName
       		FROM WebReportGroup
       		JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID
        		WHERE  WebReportGroupID = @ReportGroupID);

	/* Person Lookup By PersonID*/
	SET @PersonName = 
		(SELECT Person.PersonFirst + ' ' + Person.PersonLast
		FROM Person
		WHERE PersonID = @PersonID);


	/* Coordinator Lookup By StatEmployeeID*/
	IF @CoordinatorID Is Not Null
	BEGIN
		SET @CoordinatorName = 
			(SELECT Person.PersonFirst + ' ' + Person.PersonLast
			FROM Person
			JOIN StatEmployee ON StatEmployee.PersonID = Person.PersonID 
			WHERE StatEmployeeID = @CoordinatorID);

	END

	/*** Add additional lookup selects here ***/
	/* Tracking Type Name Lookup By StatEmployeeID*/
	IF @TrackingTypeID Is Not Null
	BEGIN
		SET @TrackingTypeName = 
			(SELECT QATrackingTypeDescription
			FROM QATrackingType
			WHERE QATrackingTypeID =@TrackingTypeID);

	END

	/* Organization Type Name Lookup By OrganizationTypeID */
	IF @OrganizationTypeID Is Not Null
	BEGIN
		SET @OrganizationTypeName = 
			(SELECT OrganizationTypeName
			FROM OrganizationType
			WHERE OrganizationTypeID = @OrganizationTypeID);
	END
	

	/* Final Select*/
	SELECT
		IsNull(@StatEmployeeName, 'N/A') AS 'StatEmployeeName',
		IsNull(@ReportGroupName, 'N/A') AS 'ReportGroupName',
		IsNull(@OrganizationName, 'N/A') AS 'OrganizationName',
		IsNull(@UserOrgName, 'N/A')AS 'UserOrgName',
		'10.0.10.0' AS 'StatTracVerson',  -- TODO: Investigate dynamic population instead of hard coding
		IsNull(@ReportGroupTitle, 'N/A')AS 'ReportGroupTitle',
		IsNull(@PersonName, 'N/A')AS 'PersonName',
		IsNull(@CoordinatorName, 'N/A') AS 'CoordinatorName',
		IsNull(@TrackingTypeName, 'N/A') AS 'TrackingTypeName',
		IsNull(@OrganizationTypeName, 'N/A') AS 'OrganizationTypeName';
		
GO
