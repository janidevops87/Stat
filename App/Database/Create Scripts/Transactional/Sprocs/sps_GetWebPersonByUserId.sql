SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetWebPersonByUserId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetWebPersonByUserId]
GO



CREATE PROCEDURE sps_GetWebPersonByUserId (@userName varchar(16) = NULL, @OrgId integer = 0,@UserId  integer = 0)
/*
   Search the WebPerson table by userId () to find any matches for that user by that organization.
   Created 3/17/05 - Scott Plummer

*/
AS

SET @userName = @userName + '%'

IF @OrgId = 194  -- Allow StatLine users to edit anyone.
   BEGIN
	-- A
	SELECT DISTINCT WP.WebPersonId, WP.WebPersonUserName
		FROM WebPerson WP 
		JOIN Person PE ON WP.PersonId = PE.PersonId
		WHERE WP.WebPersonUserName LIKE @userName
		ORDER BY WP.WebPersonUserName;
   END

ELSE  -- Restrict access by OrgId
   BEGIN
		--SELECT DISTINCT WP.WebPersonId, WP.WebPersonUserName
		--FROM WebPerson WP 
		--JOIN Person PE ON WP.PersonId = PE.PersonId
		-- WHERE (PE.OrganizationId IN
		--(SELECT WRGO.OrganizationId 
		--FROM WebReportGroupOrg WRGO
		--JOIN WebReportGroup WRG ON WRGO.WebReportGroupId = WRG.WebReportGroupId
		--WHERE WRG.OrgHierarchyParentID = @OrgId)
		--OR PE.OrganizationId = @OrgId)
		--AND WP.WebPersonUserName LIKE @username
		--ORDER BY WP.WebPersonUserName;

		SELECT DISTINCT WP.WebPersonId, WP.WebPersonUserName
		FROM WebPerson WP 
		JOIN Person PE ON WP.PersonId = PE.PersonId
		 WHERE (PE.OrganizationId IN
		(SELECT Organization.OrganizationID 
		FROM SourceCodeOrganization INNER JOIN
                      	Organization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID INNER JOIN
                     	 OnlineHospitalSourceCodeWebPerson ON SourceCodeOrganization.SourceCodeID = OnlineHospitalSourceCodeWebPerson.SourceCodeID
		WHERE  OnlineHospitalSourceCodeWebPerson.webPersonID = @UserID))
		AND WP.WebPersonUserName LIKE @username
		ORDER BY WP.WebPersonUserName;
   END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

