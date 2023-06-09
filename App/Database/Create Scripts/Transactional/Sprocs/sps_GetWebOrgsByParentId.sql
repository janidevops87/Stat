SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetWebOrgsByParentId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetWebOrgsByParentId]
GO


CREATE PROCEDURE sps_GetWebOrgsByParentId (@parentId integer = 0)
/*
   When given an organization id that is in the OrgHierarchyParentID field in WebReportGroup,
   returns a list of the hospitals (OrganizationType = 10) in that WebReportGroup;
   Created 3/17/05 by Scott Plummer

*/

AS

IF @parentId = 194
   -- If the user is from StatLine, get list of all OPOs listed as OrgHierarchyParentIDs
   BEGIN
	SELECT DISTINCT (SELECT OrganizationName FROM Organization WHERE OrganizationId = @ParentId) AS ParentOrganizationName,
			OG.OrganizationID, OG.OrganizationName, OG.OrganizationName AS SortField
		FROM Organization OG
		WHERE OrganizationID IN 
		(SELECT DISTINCT OrgHierarchyParentID from WebReportGroup)
		AND OrganizationTypeId = 1
		ORDER BY SortField;
   END

ELSE
   -- If the user is not a StatLine user
   BEGIN
	-- First, get the Org information for the ParentId
	(SELECT OrganizationName AS ParentOrganizationName, 	OrganizationID, OrganizationName, 'AAAAA' AS SortField
		FROM Organization WHERE OrganizationId = @parentId)
	UNION
	-- Then get all its children
	(SELECT DISTINCT (SELECT OrganizationName FROM Organization WHERE OrganizationId = @ParentId) AS ParentOrganizationName,
			OG.OrganizationID, OG.OrganizationName, OG.OrganizationName AS SortField
		FROM Organization OG 
		JOIN WebReportGroupOrg WRGO ON OG.OrganizationId = WRGO.OrganizationID
		JOIN WebReportGroup WRG ON WRGO.WebReportGroupID = WRG.WebReportGroupID	
		WHERE WRG.OrgHierarchyParentID = @ParentId
		AND OG.OrganizationTypeId = 10)
	ORDER BY SortField;
   END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

