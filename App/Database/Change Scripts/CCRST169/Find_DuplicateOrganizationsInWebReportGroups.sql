/* CCRST169 Release - Find Duplicate Organization in Report Groups 
	05/03/2012	ccarroll

	INSTRUCTIONS:
		1. Run script to find duplicate organizations in Report Groups
		2. To correct duplicates run the following script:
			a. Fix_DuplicateOrganizationsInReportGroups.sql

*/
SET NOCOUNT ON

DECLARE @OrganizationID int = 0,
		@WebReportGroupID int = 0

--/* 
SELECT	
		ParentOrg.OrganizationName AS Group_Owner,
		WebReportGroup.WebReportGroupName,
		WebReportGroup.WebReportGroupID,
		DuplicateOrg.OrganizationName AS DuplicateOrganizationName,
		DuplicateOrg.OrganizationID,
		DuplicateOrg.OrganizationCity,
		DuplicateOrgState.StateName,
		DuplicateOrgType.OrganizationTypeName,
		COUNT(*) AS Duplicates
FROM WebReportGroupOrg
JOIN WebReportGroup ON  WebReportGroupOrg.WebReportGroupID = WebReportGroup.WebReportGroupID
JOIN Organization DuplicateOrg ON DuplicateOrg.OrganizationID = WebReportGroupOrg.OrganizationID
JOIN [State] DuplicateOrgState ON DuplicateOrgState.StateID = DuplicateOrg.StateID
JOIN OrganizationType DuplicateOrgType ON DuplicateOrgType.OrganizationTypeID = DuplicateOrg.OrganizationTypeID
JOIN Organization ParentOrg ON ParentOrg.OrganizationID = WebReportGroup.OrgHierarchyParentID

--WHERE WebReportGroupOrg.WebReportGroupID = 277
GROUP BY 
		ParentOrg.OrganizationName,
		WebReportGroup.WebReportGroupName,
		WebReportGroup.WebReportGroupID,
		DuplicateOrg.OrganizationName,
		DuplicateOrg.OrganizationID,
		DuplicateOrg.OrganizationCity,
		DuplicateOrgState.StateName,
		DuplicateOrgType.OrganizationTypeName
HAVING COUNT(*) > 1
