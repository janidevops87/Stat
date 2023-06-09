SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AuthenticateUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AuthenticateUser]
GO






/****** Object:  Stored Procedure dbo.sps_AuthenticateUser    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE sps_AuthenticateUser

		@vUserName	varchar(15)	= null,
		@vPassword	varchar(20)	= null,
		@vUserID	int		= null,
		@vUserOrgID	int		= null

AS
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
**  08/06/2018		Ilya Osipov				Using HashedPassword when @vPassword is null
**  08/11/2018		Ilya Osipov				Removed redundatnt update of internal session id
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	DECLARE @TargetHashedPassword VARCHAR(100);

	SELECT @TargetHashedPassword = CASE 
			WHEN @vPassword IS NULL THEN HashedPassword
			ELSE  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@vPassword+ CONVERT(VARCHAR(100),[SaltValue])), 2)
			END
		FROM [dbo].[WebPerson]
		JOIN 	Person ON Person.PersonID = WebPerson.PersonID
		WHERE [WebPersonUserName] = @vUserName 
		AND 	Person.Inactive <> 1;

		IF @vUserID is null
		BEGIN
			UPDATE WebPerson
			SET InternalSessionID = newid()
			WHERE 	WebPersonUserName = @vUserName
    				AND HashedPassword = @TargetHashedPassword;
					
	    	SELECT 	OrganizationID, WebPersonID, InternalSessionID	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID
	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	HashedPassword = @TargetHashedPassword
    		AND 	Person.Inactive <> 1;
		END
		ELSE
		BEGIN		

			SELECT 	WebPersonID, InternalSessionID
			FROM	WebPerson
			JOIN	Person ON Person.PersonID = WebPerson.PersonID			
			WHERE	WebPersonID = @vUserID
			AND	OrganizationID = @vUserOrgID;
		END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

