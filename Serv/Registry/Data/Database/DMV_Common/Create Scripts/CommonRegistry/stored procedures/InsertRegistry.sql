IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertRegistry]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertRegistry]
			PRINT 'Dropping Procedure: InsertRegistry'
	END

PRINT 'Creating Procedure: InsertRegistry'
GO

CREATE PROCEDURE [dbo].[InsertRegistry]
(
	@RegistryID int = NULL OUTPUT,
	@RegistryOwnerID int = NULL,
	@SSN varchar(11) = NULL,
	@DOB datetime = NULL,
	@FirstName varchar(20) = NULL,
	@MiddleName varchar(20) = NULL,
	@LastName varchar(25) = NULL,
	@Suffix varchar(4) = NULL,
	@Gender varchar(1) = NULL,
	@Race int = NULL,
	@EyeColor varchar(5) = NULL,
	@Phone varchar(10) = NULL,
	@Email varchar(100) = NULL,
	@Comment varchar(200) = NULL,
	@Limitations varchar(1000) = NULL,
	@LimitationsOther varchar(1000) = NULL,
	@License varchar(9) = NULL,
	@Donor bit,
	@DonorConfirmed bit,
	@OnlineRegDate datetime = NULL,
	@SignatureDate datetime = NULL,
	@MailerDate datetime = NULL,
	@DeleteFlag bit,
	@DeceaseDate datetime = NULL,
	@PreviousDonor bit = NULL,
	@PreviousDonorConfirmed bit = NULL,
	@LastStatEmployeeID int = NULL,
	@RegisteredByID int = NULL
)
/******************************************************************************
**		File: InsertRegistry.sql
**		Name: InsertRegistry
**		Desc:  National Web Registry
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 02/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/19/2009	ccarroll	initial
**		02/28/2012	ccarroll	Added RegisteredByID
**		03/13/2012	ccarroll	Added for inclusion in release
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [Registry]
	(
		[RegistryOwnerID],
		[SSN],
		[DOB],
		[FirstName],
		[MiddleName],
		[LastName],
		[Suffix],
		[Gender],
		[Race],
		[EyeColor],
		[Phone],
		[Email],
		[Comment],
		[Limitations],
		[LimitationsOther],
		[License],
		[Donor],
		[DonorConfirmed],
		[OnlineRegDate],
		[SignatureDate],
		[MailerDate],
		[DeleteFlag],
		[DeceaseDate],
		[PreviousDonor],
		[PreviousDonorConfirmed],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		[RegisteredByID]
	)
	VALUES
	(
		@RegistryOwnerID,
		@SSN,
		@DOB,
		@FirstName,
		@MiddleName,
		@LastName,
		@Suffix,
		@Gender,
		@Race,
		@EyeColor,
		@Phone,
		@Email,
		@Comment,
		@Limitations,
		@LimitationsOther,
		@License,
		@Donor,
		@DonorConfirmed,
		@OnlineRegDate,
		@SignatureDate,
		@MailerDate,
		@DeleteFlag,
		@DeceaseDate,
		@PreviousDonor,
		@PreviousDonorConfirmed,
		GetDate(), --@CreateDate,
		GetDate(), --@LastModified,
		@LastStatEmployeeID,
		1, --Create @AuditLogTypeID
		@RegisteredByID
	)

	SELECT RegistryID,
		@RegistryOwnerID,
		@SSN,
		@DOB,
		@FirstName,
		@MiddleName,
		@LastName,
		@Suffix,
		@Gender,
		@Race,
		@EyeColor,
		@Phone,
		@Email,
		@Comment,
		@Limitations,
		@LimitationsOther,
		@License,
		@Donor,
		@DonorConfirmed,
		@OnlineRegDate,
		@SignatureDate,
		@MailerDate,
		@DeleteFlag,
		@DeceaseDate,
		@PreviousDonor,
		@PreviousDonorConfirmed,
		@RegisteredByID

	FROM Registry
	WHERE  RegistryID = SCOPE_IDENTITY();

	RETURN @@Error
GO