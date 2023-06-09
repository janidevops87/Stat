SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineSourceCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineSourceCode]
GO




CREATE PROCEDURE sps_OnlineSourceCode
		@WebPersonID as int

AS

Declare 
	@WebReportGroupID as int
/*

-- set @parentId = 2309
IF @OrgTypeID = 1
	Begin
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
		End
else
IF @OrgTypeID<> 1 
Begin


			SELECT Organization.OrganizationID, Organization.OrganizationName, Organization.OrganizationAddress1,
		 Organization.OrganizationAddress2, Organization.OrganizationCity, County.CountyName, State.StateAbbrv,
		 Organization.OrganizationZipCode, OrganizationType.OrganizationTypeName, Organization.OrganizationConsentInterval 
		FROM SourceCodeOrganization JOIN Organization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID
		 JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID JOIN County
		 ON Organization.CountyID = County.CountyID JOIN State ON Organization.StateID = State.StateID 
		WHERE SourceCodeOrganization.SourceCodeID =@parentid ORDER BY Organization.OrganizationName ASC 
end

*/

select  @WebReportGroupID = ReportGroupID  from OnlineHospitalAccount where webpersonID =  @WebPersonID  

SELECT WebReportGroupOrg.WebReportGroupOrgID, Organization.OrganizationName,Organization.OrganizationID, Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName FROM WebReportGroup JOIN WebReportGroupOrg ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID INNER JOIN ((Organization INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) INNER JOIN State ON Organization.StateID = State.StateID) ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
 WHERE WebReportGroup.WebReportGroupID = @WebReportGroupID ORDER BY Organization.OrganizationName ASC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

