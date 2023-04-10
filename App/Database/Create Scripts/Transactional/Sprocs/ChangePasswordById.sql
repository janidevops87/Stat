

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ChangePasswordById')
	BEGIN
		PRINT 'Dropping Procedure ChangePasswordById'
		DROP Procedure ChangePasswordById
	END
GO

PRINT 'Creating Procedure ChangePasswordById'
GO

CREATE PROCEDURE dbo.ChangePasswordById
	@userId	int,
	@password	varchar(20),
	@LastStatEmployeeID int,
	@AuditLogTypeID int = null	
AS
/******************************************************************************
**		File: ChangePasswordById.sql
**		Name: ChangePasswordById
**		Desc: changes a users password
**
**              
** 
**		Called by:   Reporting Site
**              
**
**		Auth: Bret Knoll
**		Date: 10/19/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**    10/19/2007	Bret Knoll			initial 
**	  11/12/2007	Bret Knoll			Add fields for AuditTrail
**	  07/16/2018	Ilya Osipov			Added HashedPassword logic
**	  08/06/2018	Ilya Osipov			Using HashedPassword when @vPassword is null
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*******************************************************************************/
DECLARE @TargetHashedPassword VARCHAR(100);

	SELECT @TargetHashedPassword = CASE 
			WHEN @password IS NULL THEN HashedPassword
			ELSE  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@password+ CONVERT(VARCHAR(100),[SaltValue])), 2)
			END
		FROM [dbo].[WebPerson]
		WHERE WebPersonID = @userId;

	UPDATE 
		WebPerson
	SET 
		HashedPassword = @TargetHashedPassword,
		LastStatEmployeeID = @LastStatEmployeeID ,
		AuditLogTypeID = @AuditLogTypeID,
		LastModified = GetDate()
	WHERE 
		WebPersonID = @userId

RETURN




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

