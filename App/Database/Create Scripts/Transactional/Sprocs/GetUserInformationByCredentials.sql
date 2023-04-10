IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetUserInformationByCredentials')
	BEGIN
		PRINT 'Dropping Procedure GetUserInformationByCredentials'
		DROP  Procedure  GetUserInformationByCredentials
	END

GO

PRINT 'Creating Procedure GetUserInformationByCredentials'
GO
CREATE Procedure GetUserInformationByCredentials
	@userPassword varchar(20) = NULL,
	@userName VARCHAR(15) = NULL,
	@userOrganizationID int = NULL OUTPUT,
	@userID int = NULL OUTPUT,
	@userDisplayName VARCHAR(100) = NULL OUTPUT,
	@userOrganizationName VARCHAR(80) = NULL OUTPUT,
	@statEmployeeID INT = NULL OUTPUT,
	@timeZone VARCHAR(2) = NULL OUTPUT,
	@SessionID uniqueidentifier = NULL

AS

/******************************************************************************
**		File: 
**		Name: GetUserInformationByCredentials
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:  ReportReferenceDB.GetWebPersonInformation 
**              
**		Parameters:
**		Input						
**     ----------					
**		@userPassword varchar(20) = NULL,
**		@userName VARCHAR(15) = NULL,
**		
**		Output
**		--------
**		@userOrganizationID int = NULL OUTPUT,
**		@userID int = NULL OUTPUT,
**		@userDisplayName VARCHAR(100) = NULL OUTPUT,
**		@userOrganizationName VARCHAR(80) = NULL OUTPUT
**
** 
**
**		Auth: Bret Knoll
**		Date: 3/14/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		3/14/07		Bret Knoll			initial
**		1/22/09		Bret Knoll			modified so either userOrganzationID or userpassword can be supplied.
**		7/19/2018	Ilya Osipov			Added HashedPassword code
**		08/06/2018	Ilya Osipov			Using HashedPassword when @vPassword is null
**		08/09/2018	Ilya Osipov			Adding SessionId condition in Where claus
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*******************************************************************************/

DECLARE @TargetHashedPassword VARCHAR(100);

	SELECT @TargetHashedPassword = CASE 
			WHEN @userPassword IS NULL THEN HashedPassword
			ELSE  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@userPassword+ CONVERT(VARCHAR(100),[SaltValue])), 2)
			END
		FROM [dbo].[WebPerson]
		JOIN 	Person ON Person.PersonID = WebPerson.PersonID
		WHERE [WebPersonUserName] = @userName 
		AND 	Person.Inactive <> 1;
	
	SELECT
		@userOrganizationID = o.OrganizationID,
		@userID = wp.WebPersonID,
		@userDisplayName = ISNULL(p.PersonFirst , '') + ' ' + ISNULL(p.PersonLast , ''),
		@userOrganizationName = o.OrganizationName,
		@statEmployeeID = ISNULL(se.StatEmployeeID, -1),
		@timeZone = ISNULL(tz.TimeZoneAbbreviation, '')
	FROM
		WebPerson wp
	JOIN
		Person p ON p.PersonID = wp.PersonID
	JOIN
		Organization o ON o.OrganizationID = p.OrganizationID	
	LEFT JOIN
		StatEmployee se ON se.PersonID = p.PersonID
	LEFT JOIN 
		TimeZone tz ON o.TimeZoneId = tz.TimeZoneID
	WHERE
		wp.HashedPassword = @TargetHashedPassword
	AND	
		wp.WebPersonUserName = @userName	
	AND 		
		o.OrganizationID = isnull(@userOrganizationID, o.OrganizationID)
	AND 
		wp.InternalSessionID = @SessionID 
	AND 
		P.InActive = 0	



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


