/******************************************************************************
**	File: sps_AuthenticateUser.sql
**	Name: sps_AuthenticateUser
**	Desc: Get OrganizationID, WebPersonID with checking [HashedPassword] value. Old sps wass added by Ilya Osipov
**	Auth: Ilya Osipov	
**	Date: May 25 2018
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**  06/13/2018		Ilya Osipov				initial
*******************************************************************************/
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AuthenticateUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AuthenticateUser]
GO





CREATE PROCEDURE [dbo].[sps_AuthenticateUser]

		@vUserName	varchar(15)	= null,
		@vPassword	varchar(20)	= null,
		@vUserID	int		= null,
		@vUserOrgID	int		= null

AS


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

declare @TargetHashedPassword VARCHAR(100)

select @TargetHashedPassword =  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@vPassword+ CONVERT(VARCHAR(100),[SaltValue])), 2)
FROM [ReferralTest].[dbo].[WebPerson]
JOIN 	Person ON Person.PersonID = WebPerson.PersonID
where [WebPersonUserName] = @vUserName 
AND 	Person.Inactive <> 1;

	IF @vUserID is null

	    	SELECT 	OrganizationID, WebPersonID 
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	HashedPassword = @TargetHashedPassword
    		AND 	Person.Inactive <> 1;

	ELSE

		SELECT 	WebPersonID

		FROM	WebPerson
		JOIN	Person ON Person.PersonID = WebPerson.PersonID
			
		WHERE	WebPersonID = @vUserID
		AND	OrganizationID = @vUserOrgID;




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

