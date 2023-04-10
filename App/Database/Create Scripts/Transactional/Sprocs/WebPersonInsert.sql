

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'WebPersonInsert')
	BEGIN
		PRINT 'Dropping Procedure WebPersonInsert';
		DROP Procedure WebPersonInsert;
	END
GO

PRINT 'Creating Procedure WebPersonInsert';
GO
CREATE Procedure WebPersonInsert
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
**	File: WebPersonInsert.sql
**	Name: WebPersonInsert
**	Desc: Inserts WebPerson Based on Id field 
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
**	07/11/2018		Ilya Osipov			Removed WebPersonPassword from the code
**	07/16/2018		Ilya Osipov			Removed WebPersonPasswordConfirm from the code
**	10/26/2020		Mike Berenson		Added input parameter: PasswordExpiration
*******************************************************************************/

INSERT	WebPerson
	(
		WebPersonUserName,
		PersonID,
		UnusedField1,
		LastModified,
		WebPersonSessionCounter,
		UnusedField2,
		WebPersonLastSessionAccess,
		WebPersonEmail,
		UpdatedFlag,
		WebPersonUserAgent,
		Access,
		LastStatEmployeeID,
		AuditLogTypeID,
		SaltValue,
		HashedPassword,
		PasswordExpiration
	)
VALUES
	(
		@WebPersonUserName,
		@PersonID,
		@UnusedField1,
		@LastModified,
		@WebPersonSessionCounter,
		@UnusedField2,
		@WebPersonLastSessionAccess,
		@WebPersonEmail,
		@UpdatedFlag,
		@WebPersonUserAgent,
		@Access,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1), /* insert */
		@SaltValue,
		@HashedPassword,
		@PasswordExpiration
	);

SET @WebPersonID = SCOPE_IDENTITY();

EXEC WebPersonSelect @WebPersonID;

GO

GRANT EXEC ON WebPersonInsert TO PUBLIC;
GO
