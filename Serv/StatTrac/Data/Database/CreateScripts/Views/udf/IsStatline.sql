
/****** Object:  UserDefinedFunction [dbo].[IsStatline]    Script Date: 04/04/2008 09:15:24 ******/
IF  EXISTS (
			SELECT * 
			FROM sysobjects 
			WHERE id = OBJECT_ID(N'[dbo].[IsStatline]') 
			AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROPPING FUNCTION [dbo].[IsStatline] '
	DROP FUNCTION [dbo].[IsStatline] 
END	
PRINT 'CREATING FUNCTION [dbo].[IsStatline] '

 /****** Object:  UserDefinedFunction [dbo].[IsStatline]    Script Date: 04/04/2008 09:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[IsStatline] 
(
	@WebPersonId int
)
/******************************************************************************
**		File: 
**		Name: GetUsersInRole
**		Desc: Determines if a user is a Statline Employee
**
**		Called by:  Admin and Roles storedprocedures
**              
**		Author:		Bret Knoll
**		Create date: 04/04/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		04/04/08	Bret Knoll			Initial
*******************************************************************************/
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @IsStatline bit

	SELECT 
		@IsStatline =	CASE 
						WHEN p.OrganizationID = 194 
						THEN 1 
						ELSE 0 
						END 
	FROM 
		Person p
	WHERE 
		p.PersonID IN	(
							SELECT DISTINCT							
								PersonID 
							FROM 
								WebPerson 
							WHERE 
								WebPersonID = @WebPersonId)

	
	-- Return the result of the function
	RETURN @IsStatline

END