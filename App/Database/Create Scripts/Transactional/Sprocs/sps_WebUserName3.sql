SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserName3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserName3]
GO

/* 07/15/2004 - CAB - Modified stored procedure - Added ORDER BY statement. Results were not being grouped by
organization, and usernames were not being sorted
*/

CREATE PROCEDURE sps_WebUserName3
		@vUserName 		Varchar(500)= '',
		@ORGID		int=NULL,
		@UserID		int=NULL
AS

If @vUserName <> ''  AND @ORGID IS NOT NULL
BEGIN
	SELECT @vUserName =replace(@vUserName, '*', '%')
	IF @ORGID <> 194
	BEGIN
		
		SELECT DISTINCT WP.WebPersonId, WP.WebPersonUserName, PE.PersonFirst,PE.PersonLast,Organization.OrganizationName
		FROM WebPerson WP
		 JOIN Person PE ON WP.PersonId = PE.PersonId
		JOIN Organization ON Organization.OrganizationID = PE.OrganizationID
		 WHERE (PE.OrganizationId IN
		(SELECT Organization.OrganizationID 
		FROM SourceCodeOrganization INNER JOIN
                      	Organization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID INNER JOIN
                     	 OnlineHospitalSourceCodeWebPerson ON SourceCodeOrganization.SourceCodeID = OnlineHospitalSourceCodeWebPerson.SourceCodeID
		WHERE  OnlineHospitalSourceCodeWebPerson.webPersonID = @UserID))
		AND WP.WebPersonUserName LIKE @vusername
		ORDER BY WP.WebPersonUserName;

/*SELECT * FROM webperson, person, organization
		WHERE WebPersonUserName like @vUserName
		AND person.personid=webperson.personid
		AND person.organizationid=organization.organizationid
		AND organization.organizationid in (
			SELECT DISTINCT Organization.OrganizationID
			FROM WebReportGroup
			JOIN WebReportGroupOrg ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID
			INNER JOIN ((Organization INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID)
			INNER JOIN State ON Organization.StateID = State.StateID) ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
			WHERE WebReportGroup.WebReportGroupID in (
			SELECT DISTINCT WebReportGroupID
			FROM WebReportGroup
			WHERE OrgHierarchyParentID = @ORGID
			))
		AND organization.organizationid <> @ORGID
		UNION
		SELECT * FROM webperson, person, organization
		WHERE WebPersonUserName like @vUserName
		AND person.personid=webperson.personid
		AND person.organizationid=organization.organizationid
		AND organization.organizationid =@ORGID
		ORDER BY Organization.OrganizationName Asc, WebPerson.WebPersonUserName Asc*/
	END
	ELSE
	BEGIN
		/*SELECT * FROM webperson, person, organization
		WHERE WebPersonUserName like @vUserName
		AND person.personid=webperson.personid
		AND person.organizationid=organization.organizationid
		ORDER BY Organization.OrganizationName Asc, WebPerson.WebPersonUserName Asc*/
		select Distinct  WP.WebPersonId, WP.WebPersonUserName, PE.PersonFirst,PE.PersonLast,Organization.OrganizationName
		FROM WebPerson WP
		 JOIN Person PE ON WP.PersonId = PE.PersonId
		JOIN Organization ON Organization.OrganizationID = PE.OrganizationID
		WHERE WP.WebPersonUserName LIKE @vuserName
		ORDER BY WP.WebPersonUserName;
	END		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

