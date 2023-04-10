IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPersonIDByWebPersonId')
	BEGIN
		PRINT 'Dropping Procedure GetPersonIDByWebPersonId'
		DROP  Procedure  GetPersonIDByWebPersonId
	END

GO

PRINT 'Creating Procedure GetPersonIDByWebPersonId'
GO

CREATE Procedure GetPersonIDByWebPersonId
	@WebPersonID INT,
	@returnVal int OUTPUT
AS

/******************************************************************************
**		File: GetPersonIDByWebPersonId.sql
**		Name: GetPersonIDByWebPersonId
**		Desc: retrieves PersonID
**
**		
**
**		Auth: jth
**		Date: 4/09
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		04/09		jth					get personid with webpersonid
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
set @returnval = 0
SELECT
	@returnVal=PersonID
FROM         
	Person
WHERE     
	(PersonID = (
	SELECT     PersonID
	FROM         WebPerson
	WHERE     (WebPersonID = @WebPersonID))
	)
	
	
RETURN @returnVal

GO
 