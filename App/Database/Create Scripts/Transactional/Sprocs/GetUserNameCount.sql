IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetUserNameCount')
	BEGIN
		PRINT 'Dropping Procedure GetUserNameCount'
		DROP  Procedure  GetUserNameCount
	END

GO

PRINT 'Creating Procedure GetUserNameCount'
GO
CREATE Procedure GetUserNameCount
	@WebPersonUserName VARCHAR(15),
	@Inactive INT,
	@WebPersonID INT,
	@Count INT OUTPUT
AS

/******************************************************************************
**		File: GetUserNameCount.sql
**		Name: GetUserNameCount
**		Desc: Returns the number of WebPersonUserNames
**
**		Called by: UserAdminEditControl.ascx  
**              
**
**		Auth: Bret Knoll	
**		Date: 2/11/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		2/11/08		Bret Knoll			initial
**		7/20/18		Ilya Osipov			Removed conditions with WebPersonPassword
*******************************************************************************/
DECLARE 
	@currrentInactive INT,
	@currentWebPersonUserName VARCHAR(100)
SET @Count = 0
--- check to see if the Inactive is 0. 
--- If 0 check for duplicates
--- If 1 return 0 
IF (@Inactive = 0)
BEGIN
	--- get the previous Inactive value
	SELECT
		@currrentInactive = Inactive,
		@currentWebPersonUserName = WebPersonUserName
	FROM 
		WebPerson wp
	JOIN 
		person p ON p.PersonID  = wp.PersonID
	WHERE 
		WebPersonID = @WebPersonID
	
	--- compare the current and new Inactive values
	--- if currentInactive is NULL assume 1, this forces a check
	--- if values are different the check count
	--- if values are the same nothing has changed, do not check
	IF((ISNULL(@currrentInactive, 1) <> @Inactive) OR (ISNULL(@currentWebPersonUserName, '') <> @WebPersonUserName))
	BEGIN	
		SELECT 
			@Count = COUNT(*) 
		FROM 
			WebPerson wp
		JOIN 
			person p ON p.PersonID  = wp.PersonID
		WHERE					 
					WebPersonUserName = @WebPersonUserName
				AND	p.InActive = 0
	END	
	
	IF ((ISNULL(@currentWebPersonUserName, '') <> @WebPersonUserName OR @currrentInactive <> @Inactive )AND @Count > 0)
	BEGIN
		SET @Count = @Count + 1
	END
END

GO

GRANT EXEC ON GetUserNameCount TO PUBLIC

GO
