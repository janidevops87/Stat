IF OBJECT_ID('Api.AddConfiguration', 'P') IS NOT NULL 
	DROP PROC Api.AddConfiguration;
GO

PRINT 'Creating Procedure Api.AddConfiguration'
GO

CREATE PROCEDURE Api.AddConfiguration(@WebReportGroupId INT)
AS
		/******************************************************************************
		**	File: Api.AddConfiguration.sql 
		**	Name: AddConfiguration
		**	Desc: Insert new configuration value into Api.Configuration table
		**	Auth: Andrey Savin
		**	Date: 5/3/2018
		**	Called By: 
		*******************************************************************************/	
BEGIN

SET NOCOUNT ON;

-- Some values a constants for now, this may change later.
DECLARE @DocumentTypeId INT = 1;
DECLARE @IsActive BIT = 1;

-- Derive Org ID from WRGID.
DECLARE @OrganizationId  INT = 
	(SELECT OrgHierarchyParentID
	FROM WebReportGroup
	WHERE WebReportGroupID = @WebReportGroupId);

-- Check if passed WRGID is correct (can be resolved to an Org ID)
-- and that a configuration for that WRGID doesn't exist yet.
IF @OrganizationId IS NOT NULL AND NOT EXISTS (
	SELECT * FROM Api.Configuration
	WHERE 
		OrganizationId = @OrganizationId AND 
		WebReportGroupId = @WebReportGroupId AND 
		DocumentTypeId = @DocumentTypeId) 
BEGIN
	INSERT INTO Api.Configuration
					(WebReportGroupId
					,DocumentTypeId
					,LastRun
					,LastModified
					,OrganizationId
					,IsActive)
				VALUES
					(@WebReportGroupId
					,@DocumentTypeId
					,getdate()
					,getdate()
					,@OrganizationId
					,@IsActive);
END;			

-- Return 0 or 1 records:
-- If non-existing WRGID was passed, empty set will be returned.
-- If such configuration already existed, existing config record will be returned.
-- Otherwise newly inserted config record will be returned.
SELECT ConfigurationId FROM Api.Configuration 
WHERE WebReportGroupId = @WebReportGroupId;

END;
