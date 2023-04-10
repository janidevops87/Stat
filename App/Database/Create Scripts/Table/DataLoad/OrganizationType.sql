/***************************************************************************************************
**	Name: OrganizationType
**	Desc: Update OrganizationType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	03/04/2011	bret			Initial Script Creation
**	03/04/2011	bret			updated based on wi 2964
**	05/31/2011	ccarroll		Fixed issue with ME/Coroner's Office character set wi 12418
**	05/31/2011	ccarroll		Delete duplicate 'Justice of the Peace' ID:31 Production issue 
***************************************************************************************************/


IF exists(select top 1 OrganizationTypeName from OrganizationType where OrganizationTypeName = 'Coroners Office')
BEGIN
	UPDATE Organization
	SET OrganizationTypeID = 3
	WHERE OrganizationTypeID = 4
	
	UPDATE OrganizationType
	SET OrganizationTypeName = 'ME/Coroner''s Office'
	WHERE OrganizationTypeID = 3;
	
	DELETE OrganizationType
	WHERE OrganizationTypeID = 4;
	
	
END

IF exists(select top 1 OrganizationTypeName from OrganizationType where OrganizationTypeName = 'Medical Clinic')
BEGIN
	UPDATE Organization
	SET OrganizationTypeID = 23
	WHERE OrganizationTypeID = 29

	DELETE OrganizationType
	WHERE OrganizationTypeID = 29;
	
END

/* Remove duplicates 'Justice of the Peace' */
IF exists(select top 1 OrganizationTypeName from OrganizationType where OrganizationTypeName = 'Justice of the Peace' AND OrganizationTypeID = 31)
BEGIN
	UPDATE Organization
	SET OrganizationTypeID = 30
	WHERE OrganizationTypeID = 31
	
	DELETE OrganizationType
	WHERE OrganizationTypeID = 31;
	
END