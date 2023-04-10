  IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_GetOrganizationID]') AND xtype in (N'FN', N'IF', N'TF'))
	BEGIN
		PRINT 'Dropping Function fn_GetOrganizationID'
		DROP Function fn_GetOrganizationID
	END
GO

PRINT 'Creating Function fn_GetOrganizationID' 
GO

CREATE FUNCTION dbo.fn_GetOrganizationID
	(
		@vUserName as varchar(50),
		@vPassword as varchar(50)

	)
RETURNS int
AS
/******************************************************************************
**		File: fn_GetOrganizationID.sql
**		Name: fn_GetOrganizationID
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**	  07/16/2018	Ilya Osipov			Added HashedPassword logic
**    08/06/2018	Ilya Osipov			Using HashedPassword when @vPassword is null
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*******************************************************************************/
	BEGIN		
	DECLARE @OrganizatinID INT
	DECLARE @TargetHashedPassword VARCHAR(100);

	SELECT @TargetHashedPassword = CASE 
			WHEN @vPassword IS NULL THEN HashedPassword
			ELSE  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@vPassword+ CONVERT(VARCHAR(100),[SaltValue])), 2)
			END
		FROM [dbo].[WebPerson]
		JOIN 	Person ON Person.PersonID = WebPerson.PersonID
		WHERE [WebPersonUserName] = @vUserName 
		AND 	Person.Inactive <> 1;

	SELECT 	@OrganizatinID = OrganizationID  

    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	HashedPassword = @TargetHashedPassword
	RETURN @OrganizatinID
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 