 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetUserNameById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetUserNameById]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE GetUserNameById
	
	@userId INT = 0,
	@userOrgId INT = 0,
	@userName VARCHAR(15) = NULL OUTPUT,
	@userDisplayName VARCHAR(100) = NULL OUTPUT,
	@userOrganizationName VARCHAR(80) = NULL OUTPUT
	
	

AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

DECLARE @checkUserID INT
SET @checkUserID = 0
-- confirm user is authenticated
SELECT 
	@checkUserID = ISNULL(WebpersonID, 0)
FROM
	WebPerson wp
JOIN 
	Person	p ON p.PersonID = wp.PersonID
	
WHERE
	p.InActive = 0 -- User is Active
AND
	wp.WebPersonLastSessionAccess > DATEADD( s, -3600, getdate()) 
AND 
	wp.WebPersonID = @userId
AND 
	p.OrganizationID = @userOrgId	

	SELECT 
		@userName = WebPersonUserName,	
		@userDisplayName = ISNULL(p.PersonFirst , '') + ' ' + ISNULL(p.PersonLast , ''),
		@userOrganizationName = o.OrganizationName
	FROM
		WebPerson wp
	JOIN
		Person p ON p.PersonID = wp.PersonID
	JOIN
		Organization o ON o.OrganizationID = p.OrganizationID	
	WHERE
		WebPersonID = @checkUserID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

