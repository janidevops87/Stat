  /***************************************************************************************************
**	Name: WebReportGroupOrg
**	Desc: Add Initial Data and cleanup existing data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation 
***************************************************************************************************/

PRINT 'remove WebReportGroupOrg  where OrganizationID does not exist'
delete WebReportGroupOrg 
where WebReportGroupOrg.WebReportGroupOrgID in (
	select WebReportGroupOrg.WebReportGroupOrgID 
	from WebReportGroupOrg 
	where WebReportGroupOrg.OrganizationID not in (select Organization.OrganizationID from Organization)
)

PRINT 'remove WebReportGroupOrg  where WebReportGroupID does not exist'
DELETE WebReportGroupOrg 
where WebReportGroupID NOT IN (select WebReportGroupID from WebReportGroup)

PRINT 'Remove WebReportGroupOrg  where OrganizationID does not exist in Organization'
delete 
	WebReportGroupOrg 
where 
	OrganizationID not in (select OrganizationID from Organization )