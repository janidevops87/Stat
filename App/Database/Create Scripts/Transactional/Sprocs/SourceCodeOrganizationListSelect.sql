 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeOrganizationListSelect')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeOrganizationListSelect'
		DROP Procedure SourceCodeOrganizationListSelect
	END
GO

PRINT 'Creating Procedure SourceCodeOrganizationListSelect'
GO
CREATE Procedure SourceCodeOrganizationListSelect
(		
		@SourceCodeID int = null,
		@UserOrganizationID int = null
)
AS
/******************************************************************************
**	File: SourceCodeOrganizationListSelect.sql
**	Name: SourceCodeOrganizationListSelect
**	Desc: Selects multiple rows of Organization Based on Id  fields
**  Used: SourceCodeSourceCodeControl.cbFullName   
**	Auth: ccarroll	
**	Date: 07/13/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	07/13/2010		ccarroll				Initial 
**	04/04/2011		bret					Modified Organization Inactive to OrganizationStatusId = 3
**	04/11/2011		ccarroll				Changed to return only Active (Verified and Not-Verified) Organizations
**	06/14/2011		ccarroll				Created ReportGroup bypass for StatLine User wi: 12879 
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
If IsNull(@UserOrganizationID, 0) <> 194

BEGIN	

	SELECT DISTINCT
		Organization.OrganizationID AS ListId,
		Organization.OrganizationName AS FieldValue
	FROM Organization
		JOIN WebReportGroupOrg ON Organization.OrganizationId = WebReportGroupOrg.OrganizationID
		JOIN WebReportGroup ON WebReportGroupOrg.WebReportGroupID = WebReportGroup.WebReportGroupID	

	WHERE
		IsNull(Organization.OrganizationStatusId, 1) <> 3 -- 3, Inactive
		AND WebReportGroup.OrgHierarchyParentID = IsNull(@UserOrganizationID, WebReportGroup.OrgHierarchyParentID)

	ORDER BY 2
END
ELSE
BEGIN
	SELECT DISTINCT
		Organization.OrganizationID AS ListId,
		Organization.OrganizationName AS FieldValue
	FROM Organization

	WHERE
		IsNull(Organization.OrganizationStatusId, 1) <> 3 -- 3, Inactive

	ORDER BY 2
END

GO

GRANT EXEC ON SourceCodeOrganizationListSelect TO PUBLIC
GO



