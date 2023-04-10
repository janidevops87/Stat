/***************************************************************************************************
**	Name: WebReportGroup
**	Desc: Add Initial Data and cleanup existing data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation 
***************************************************************************************************/
--- remove WebReportGroup that do not exist in OrganizationID

delete WebReportGroup 
where WebReportGroupID in (
	select WebReportGroup.WebReportGroupID
	from WebReportGroup 
	where WebReportGroup.OrgHierarchyParentID not in (select Organization.OrganizationID from Organization)
	)
