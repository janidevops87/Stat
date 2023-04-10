

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'WebPersonUpdate')
	BEGIN
		PRINT 'Dropping Procedure WebPersonUpdate';
		DROP Procedure WebPersonUpdate;
	END
GO

PRINT 'Creating Procedure WebPersonUpdate';
GO
CREATE Procedure WebPersonUpdate
(
		@WebPersonID int = null output,
		@WebPersonUserName varchar(15) = null,
		@PersonID int = null,		
		@UnusedField1 int = null,
		@LastModified datetime = null,
		@WebPersonSessionCounter int = null,
		@UnusedField2 int = null,
		@WebPersonLastSessionAccess smalldatetime = null,
		@WebPersonEmail varchar(100) = null,
		@UpdatedFlag smallint = null,
		@WebPersonUserAgent varchar(100) = null,
		@Access int = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@SaltValue varchar(100) = null,
		@HashedPassword varchar(100) = null,
		@PasswordExpiration datetime = null
)
AS
/******************************************************************************
**	File: WebPersonUpdate.sql
**	Name: WebPersonUpdate
**	Desc: Updates WebPerson Based on Id field 
**	Auth: Bret Knoll
**	Date: 10/29/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/29/2010		Bret Knoll			Initial Sproc Creation
**	06/21/2018		Ilya Osipov			Added @SaltValue and @HashedPassword
**	07/06/2018		Ilya Osipov			Added Check @SaltValue and @HashedPassword on NULL value
**	07/11/2018		Ilya Osipov			Removed WebPersonPassword from the code
**	07/16/2018		Ilya Osipov			Removed WebPersonPasswordConfirm from the code
**	10/24/2020		Mike Berenson		Added logic that sets PasswordExpiration to expired when the password is changed
**	10/26/2020		Mike Berenson		Added input parameter: PasswordExpiration
**	10/26/2020		Mike Berenson		Removed PasswordExpiration logic and left input parameter
*******************************************************************************/

BEGIN

	IF(@SaltValue IS NULL OR @HashedPassword IS NULL)
	BEGIN
		SELECT @SaltValue = SaltValue,
		@HashedPassword = HashedPassword
		FROM dbo.WebPerson
		WHERE 
			WebPersonID = @WebPersonID;
	END

	UPDATE
		dbo.WebPerson 	
	SET 
		WebPersonUserName = @WebPersonUserName,
		PersonID = @PersonID,
		UnusedField1 = @UnusedField1,
		LastModified = GetDate(),
		WebPersonSessionCounter = @WebPersonSessionCounter,
		UnusedField2 = @UnusedField2,
		WebPersonLastSessionAccess = @WebPersonLastSessionAccess,
		WebPersonEmail = @WebPersonEmail,
		UpdatedFlag = @UpdatedFlag,
		WebPersonUserAgent = @WebPersonUserAgent,
		Access = @Access,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), /* 3 modified */
		SaltValue = @SaltValue,
		HashedPassword = @HashedPassword,
		PasswordExpiration = ISNULL(@PasswordExpiration, PasswordExpiration)
	WHERE 
		WebPersonID = @WebPersonID;			

END
GO

GRANT EXEC ON WebPersonUpdate TO PUBLIC;
GO
