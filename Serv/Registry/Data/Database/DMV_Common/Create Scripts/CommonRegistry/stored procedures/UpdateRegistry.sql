IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateRegistry]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateRegistry]
	PRINT 'Dropping Procedure: UpdateRegistry'
END
	PRINT 'Creating Procedure: UpdateRegistry'
GO

CREATE PROCEDURE [dbo].[UpdateRegistry]
(
	@RegistryID int,
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
**		File: UpdateRegistry.sql
**		Name: UpdateRegistry
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
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		02/19/2009	ccarroll			initial
**		02/28/2012	ccarroll			Added RegisteredByID
**		03/13/2012	ccarroll			Added for inclusion in release
**		01/15/2014	Moonray Schepart	Added DMV Lookup for Prior Donor Status
*******************************************************************************/

AS
	SET NOCOUNT ON
	
DECLARE @State nvarchar(2);
	DECLARE @DMV_Database nvarchar(25);
	DECLARE @SelectRegistrantSQLPrefix nvarchar(1000);
	DECLARE @SelectRegistrantSQLWhereClause nvarchar(1000);
	DECLARE @RegistrantsFound int;
	DECLARE @DMVRegistrant TABLE(
			DonorStatus bit
			);		

	IF (COALESCE(@PreviousDonor, 2) = 2) -- Only do DMV lookup if PreviousDonor state not known
	BEGIN 

		--CHECK DMV BASED ON STATE REGISTRANT SPECIFIED
		SELECT @State = [State]
		FROM RegistryAddr
		WHERE RegistryID = @RegistryID;

		IF EXISTS(SELECT DSN FROM StateDSNLookup WHERE State = @State)
		BEGIN
			SELECT @DMV_Database = DSN
			FROM StateDSNLookup
			WHERE [State] = @State;				

			SET @SelectRegistrantSQLPrefix = 'SELECT DONOR FROM ' + @DMV_Database + '.dbo.DMV';
			SET @SelectRegistrantSQLWhereClause = ' WHERE FIRSTNAME = ''' + @FirstName + ''' AND LASTNAME = ''' + @LastName + ''' AND DOB = ''' + CAST(@DOB as nvarchar(20)) + ''' ';
		
			INSERT INTO @DMVRegistrant
			EXEC (@SelectRegistrantSQLPrefix + @SelectRegistrantSQLWhereClause);
		
			SELECT @RegistrantsFound = COUNT(DonorStatus)
			FROM @DMVRegistrant;

			IF (@RegistrantsFound = 1) --If more than one found, can not match with accuracy
			BEGIN			
				SELECT  @PreviousDonor  = DonorStatus,
						@PreviousDonorConfirmed = 1
				FROM @DMVRegistrant;
			END
		END
	END

	UPDATE [Registry]
	SET
		[RegistryOwnerID] = IsNull(@RegistryOwnerID, RegistryOwnerID),
		[SSN] = IsNull(@SSN, SSN),
		[DOB] = IsNull(@DOB, DOB),
		[FirstName] = IsNull(@FirstName, FirstName),
		[MiddleName] = IsNull(@MiddleName, MiddleName),
		[LastName] = IsNull(@LastName, LastName),
		[Suffix] = IsNull(@Suffix, Suffix),
		[Gender] = IsNull(@Gender, Gender),
		[Race] = IsNull(@Race, Race),
		[EyeColor] = IsNull(@EyeColor, EyeColor),
		[Phone] = IsNull(@Phone, Phone),
		[Email] = IsNull(@Email, Email),
		[Comment] = IsNull(@Comment, Comment),
		[Limitations] = IsNull(@Limitations, Limitations),
		[LimitationsOther] = IsNull(@LimitationsOther, LimitationsOther),
		[License] = IsNull(@License, License),
		[Donor] = IsNull(@Donor, Donor),
		[DonorConfirmed] = IsNull(@DonorConfirmed, DonorConfirmed),
		[OnlineRegDate] = IsNull(@OnlineRegDate, OnlineRegDate),
		[SignatureDate] = IsNull(@SignatureDate, SignatureDate),
		[MailerDate] = IsNull(@MailerDate, MailerDate),
		[DeleteFlag] = IsNull(@DeleteFlag, DeleteFlag),
		[DeceaseDate] = IsNull(@DeceaseDate, DeceaseDate),
		[PreviousDonor] = IsNull(@PreviousDonor, PreviousDonor),
		[PreviousDonorConfirmed] = IsNull(@PreviousDonorConfirmed, PreviousDonorConfirmed),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3, --Modify
		[RegisteredByID] = ISNULL(@RegisteredByID, RegisteredByID)
	WHERE 
		[RegistryID] = @RegistryID

	RETURN @@Error
GO
