IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertRegistryDlaResponseItem]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertRegistryDlaResponseItem];
			PRINT 'Dropping Procedure: InsertRegistryDlaResponseItem';
	END

PRINT 'Creating Procedure: InsertRegistryDlaResponseItem';
GO

CREATE PROCEDURE [dbo].[InsertRegistryDlaResponseItem]
(
	@RegistryDlaResponseID INT = NULL,
	@SSN VARCHAR(11) = NULL,
	@DOB DATETIME = NULL,
	@FirstName VARCHAR(20) = NULL,
	@MiddleName VARCHAR(20) = NULL,
	@LastName VARCHAR(25) = NULL,
	@Suffix VARCHAR(4) = NULL,
	@Gender VARCHAR(1) = NULL,
	@Race INT = NULL,
	@EyeColor VARCHAR(5) = NULL,
	@Addr1 VARCHAR(50) = NULL,
	@Addr2 VARCHAR(50) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@Phone VARCHAR(10) = NULL,
	@Email VARCHAR(100) = NULL,
	@Comment VARCHAR(200) = NULL,
	@Limitations VARCHAR(1000) = NULL,
	@LimitationsOther VARCHAR(1000) = NULL,
	@License VARCHAR(20) = NULL,
	@Donor BIT,
	@DonorConfirmed BIT,
	@OnlineRegDate DATETIME = NULL,
	@SignatureDate DATETIME = NULL,
	@MailerDate DATETIME = NULL,
	@DeleteFlag BIT,
	@DeceaseDate DATETIME = NULL,
	@PreviousDonor BIT = NULL,
	@PreviousDonorConfirmed BIT = NULL,
	@LastStatEmployeeID INT = NULL,
	@RegisteredByID INT = NULL
)
/******************************************************************************
**		File: InsertRegistryDlaResponseItem.sql
**		Name: InsertRegistryDlaResponseItem
**		Desc: Donate Life America Registry
**
**		Called by:   
**              
**
**		Auth: Mike Berenson
**		Date: 09/29/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------------
**      09/29/2016	Mike Berenson	Initial Stored Procedure Creation
**		10/04/2016	Mike Berenson	Added RegistryDlaResponseID
*******************************************************************************/
AS
	SET NOCOUNT ON;

	INSERT INTO [RegistryDlaResponseItem]
	(
		[RegistryDlaResponseID],
		[SSN],
		[DOB],
		[FirstName],
		[MiddleName],
		[LastName],
		[Suffix],
		[Gender],
		[Race],
		[EyeColor],
		[Addr1],
		[Addr2],
		[City],
		[State],
		[Zip],
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
		@RegistryDlaResponseID,
		@SSN,
		@DOB,
		@FirstName,
		@MiddleName,
		@LastName,
		@Suffix,
		@Gender,
		@Race,
		@EyeColor,
		@Addr1,
		@Addr2,
		@City,
		@State,
		@Zip,
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
		GETDATE(), --@CreateDate,
		GETDATE(), --@LastModified,
		@LastStatEmployeeID,
		1, --Create @AuditLogTypeID
		@RegisteredByID
	);

	SELECT RegistryDlaResponseItemID,
		@RegistryDlaResponseID,
		@SSN,
		@DOB,
		@FirstName,
		@MiddleName,
		@LastName,
		@Suffix,
		@Gender,
		@Race,
		@EyeColor,
		@Addr1,
		@Addr2,
		@City,
		@State,
		@Zip,
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

	FROM RegistryDlaResponseItem
	WHERE  RegistryDlaResponseItemID = SCOPE_IDENTITY();

	RETURN @@Error;
GO