SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AuthenticateUserv2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AuthenticateUserv2]
GO



CREATE PROCEDURE sps_AuthenticateUserv2

		@vUserName	varchar(15)	= null,
		@vPassword	varchar(20)	= null,
		@vUserID	int		= null,
		@vUserOrgID	int		= null

AS

	IF @vUserID is null

	    	SELECT 	Person.OrganizationID, WebPerson.WebPersonID ,Person.PersonID,Person.PersonFirst,Person.PersonLast, PermissionID,Organization.OrganizationTypeID,WebPerson.Access
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID
		JOIN    WebPersonPermission ON WebPersonPermission.WebPersonID = WebPerson.WebPersonID Join Organization ON Organization.OrganizationID = Person.OrganizationID
		
	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	WebPersonPassword = @vPassword
		and 	PermissionID = 192
    		--AND 	Person.Inactive <> 1

	ELSE

		SELECT 	WebPersonID,Person.PersonID

		FROM	WebPerson
		JOIN	Person ON Person.PersonID = WebPerson.PersonID
			
		WHERE	WebPersonID = @vUserID
		AND	OrganizationID = @vUserOrgID

/*
SELECT 	OrganizationID, WebPerson.WebPersonID ,Person.PersonID,Person.PersonFirst,Person.PersonLast,PermissionID 
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID 
		JOIN    WebPersonPermission ON WebPersonPermission.WebPersonID = WebPerson.WebPersonID

	    	WHERE 	WebPersonUserName = 'ncdsadmin'
    		AND 	WebPersonPassword = 'ncdsadmin' 
		and 	PermissionID = 193 */
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

