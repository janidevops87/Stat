/***Migrate CO Mobile registrants back to Colorado***
		ccarroll 03/05/2012
		Filename: Migrate_CODA_Common_Registry_to_DMV_CO.sql
		Description: Migrate mobile registry donors from Common registry to DMV_CO
		Notes:	Not Tested			
***/

DECLARE @ExistingDonors int,
		@RegistryOwnerName nvarchar(100),
		@RegistryOwnerState nvarchar(2),
		@RegistryOwnerID int = 0,
		@ExistingID int = null,
		@TransactionMessage varchar(200),

		
		/* Registry */
		@Identity int,
		@RegistryID int,
		@SSN varchar(11) = null,
		@DOB datetime = null,
		@FirstName varchar(20) = null,
		@MiddleName varchar(20) = null,
		@LastName varchar(25) = null,
		@Gender varchar(1) = null,
		@Comment varchar(200) = null,
		@Donor bit = 1,
		@DMVDonor bit = 0,
		@DeleteFlag bit = 0,
		@DonorConfirmed bit = 0,
		@SourceCode varchar(10) = 'Mobile',
		@PreviousDonorStateDMVDonor varchar(1) = null,
		@PreviousDonorStateDonor varchar(1) = null,
		@PreviousDonorStateDonorConfirmed varchar(1) = null,

		/* Address */
		@AddrTypeID int = 1,
		@Addr1 varchar(40) = null,
		@City varchar(25) = null,
		@State varchar(2) = null,
		@Zip varchar(10) = null,

		/* LogEvent */
		@EventCategoryID Int = 0,
		@EventSubCategoryID Int = 0,

		/* Audit Trail */
		@CreateDate datetime = null,
		@LastStatEmployeeID int = 0,
		@Insert int = 1,
		@Modify int = 3

SET @RegistryOwnerName = 'CODA'
SET @RegistryOwnerState = 'CO'
SET @RegistryOwnerID = (SELECT TOP 1 RegistryOwnerID FROM DMV_Common.dbo.RegistryOwner AS RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName)

/* Turn Off Counts */
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


PRINT 'Start data migration.. '

	/* Create Temp Table */
	IF OBJECT_ID('tempdb..#TEMP_Registry') is not null
	BEGIN
		DROP TABLE #TEMP_Registry
	END

	CREATE Table #TEMP_Registry
	(RegistryID int NOT NULL)

	/* Get list of Registry IDs to migrate*/
	INSERT INTO #TEMP_Registry (RegistryID)
		(SELECT Registry.RegistryID 
		FROM DMV_Common.dbo.Registry AS Registry
		JOIN DMV_Common.dbo.RegistryAddr AS RegistryAddr ON Registry.RegistryID = RegistryAddr.RegistryID
		WHERE RegistryOwnerID = @RegistryOwnerID 
		AND DeleteFlag = 0
		AND PATINDEX(@RegistryOwnerState, RegistryAddr.State) > 0 
		)
	 
SELECT * FROM #TEMP_Registry

	WHILE (SELECT Count(RegistryID) FROM #TEMP_Registry) > 0
	BEGIN
		SET @RegistryID = (SELECT Min(RegistryID) FROM #TEMP_Registry)

	/* Load donor information and check to see if already exists*/
			SELECT
				@SSN = SSN,
				@DOB = DOB,
				@FirstName = FirstName,
				@LastName = LastName,
				@Gender = Gender,
				@Comment = LEFT(Limitations, 200),
				@CreateDate = Registry.CreateDate,

				@Addr1 = [Address].Addr1,
				@City = [Address].City,
				@State = [Address].[State],
				@Zip = [Address].Zip,

				@EventCategoryID = EventRegistry.EventCategoryID

			FROM DMV_Common.dbo.Registry AS Registry
			LEFT JOIN DMV_Common.dbo.RegistryAddr [Address] ON Registry.RegistryID = [Address].RegistryID
			LEFT JOIN DMV_Common.dbo.EventRegistry EventRegistry ON Registry.RegistryID = EventRegistry.RegistryID
			WHERE Registry.RegistryID = @RegistryID


	/* Check DMV_CO for existing record*/
	SET @ExistingID = (SELECT MAX(ID) FROM DMV_CO.dbo.Registry 
							WHERE PATINDEX(UPPER(@FirstName), UPPER(FirstName)) > 0
							  AND PATINDEX(UPPER(@LastName), UPPER(LastName)) > 0
							  AND DOB = @DOB
						)

	IF ISNULL(@ExistingID, 0) > 0
	BEGIN
		BEGIN TRANSACTION UpdateRegistry
		/* Update Existing Record */
			UPDATE DMV_CO.dbo.Registry 
				SET
					SSN = IsNull(SSN, @SSN),
					DOB = ISNull(DOB, @DOB),
					FirstName = ISNull(FirstName, @FirstName),
					LastName  = ISNull(LastName, @LastName),
					Gender = ISNULL(Gender, @Gender),
					Comment = @Comment, --(200) Used as limmitations
					Donor = @Donor,
					DonorConfirmed = @DonorConfirmed, -- unconfirmed
					PreviousDonorStateDonor = CAST(Donor AS varchar),
					PreviousDonorStateDonorConfirmed = CAST(DonorConfirmed AS varchar),
					--DMVDonor = 
					--PreviousDonorStateDMVDonor = 
					LastModified = @CreateDate
			WHERE ID = @ExistingID
			
			UPDATE DMV_CO.dbo.REGISTRYADDR
				SET
					Addr1 = @Addr1,
					City = @City,
					[State] = @State,
					Zip = @Zip,
					LastModified = @CreateDate
			WHERE RegistryID = @ExistingID
					AND AddrTypeID = 1
			
			

		COMMIT TRANSACTION UpdateRegistry
		SET @TransactionMessage = 'Processing Registry ID: ' + CAST(@RegistryID AS Varchar) + ' Updating ID: ' + CAST(@ExistingID AS Varchar)
	END
	IF ISNULL(@ExistingID, 0) = 0
		BEGIN
		BEGIN TRANSACTION InsertRegistry 
		/* Insert New Record */
			INSERT INTO DMV_CO.dbo.Registry(
				SSN,
				DOB,
				FirstName,
				LastName,
				Gender,
				Comment, --(200)limit Used as limitations
				Donor,
				DonorConfirmed,
				DMVDonor,
				OnlineRegDate,
				DeleteFlag,
				LastModified,
				CreateDate
			)
			VALUES (
				@SSN,
				@DOB,
				@FirstName,
				@LastName,
				@Gender,
				@Comment, --(200) Used as limitations
				@Donor,
				@DonorConfirmed,
				@DMVDonor,
				@CreateDate, --OnlineRegDate
				@DeleteFlag,
				IsNull(@CreateDate, GetDate()),
				IsNull(@CreateDate, GetDate())
			)

			SELECT @Identity = @@Identity

			INSERT INTO DMV_CO.dbo.REGISTRYADDR
			(
				RegistryID,
				AddrTypeID,
				Addr1,
				City,
				[State],
				Zip,
				CreateDate,
				LastModified
			)
			VALUES (
				@Identity,
				@AddrTypeID,
				@Addr1,
				@City,
				@State,
				@Zip,
				IsNull(@CreateDate, GetDate()),
				IsNull(@CreateDate, GetDate())
			)

			INSERT INTO DMV_CO.dbo.EventRegistry
			(
				RegistryID,
				EventCategoryID,
				EventSubCategoryID,
				CreateDate,
				LastModified

			)
			VALUES
			(
				@Identity,
				@EventCategoryID,
				@EventSubCategoryID,
				IsNull(@CreateDate, GetDate()),
				IsNull(@CreateDate, GetDate())
			)

		COMMIT TRANSACTION InsertRegistry
		SET @TransactionMessage =  'Processing Registry ID: ' + CAST(@RegistryID AS Varchar) + ' to new ID: ' + CAST(@Identity AS Varchar)
		END		

	UPDATE DMV_Common.dbo.Registry SET DeleteFlag = 1 WHERE RegistryID = @RegistryID
	SELECT	@RegistryID AS Common_RegistryId,
			IsNull(@Identity, @ExistingID) AS RegistryId,
			@RegistryOwnerState AS RegistryOwnerState,
			GETDATE() AS TransactionDate, 
			@TransactionMessage AS TransactionMessage
	 INTO DMV_Common.dbo.CODA_MobileReferenceID
	
	DELETE #TEMP_Registry WHERE RegistryID = @RegistryID

	END --WHILE
	
PRINT 'End data migration.. '
/* Drop Temp Table */
IF OBJECT_ID('tempdb..#TEMP_Registry') is not null
BEGIN
	DROP TABLE #TEMP_Registry
END
GO