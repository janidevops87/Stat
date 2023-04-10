﻿ /*** Nebraska Organ Recovery System (NORS) Data Migration ***
		ccarroll 01/10/2011
		Filename: NORS_RegistryDataMigration.sql
		Description: Migrate existing NORS Registry donors to new location (DMV_Common)
		Notes:	If the following EventCategory and SubCategory are not present for registry owner
				NORS, the migration effort will abort:

				EventCategory:		'Existing Donors'
				EventSubCategory:	'Nebraska Web Registry'
				
				The donors migrated	from DMV_NE.Registry are set to the above events by default.
				After migration occurs, the events may be renamed or made active.
				
				Run This migration from DMV_NE Database 
***/

DECLARE @ExistingDonors int
SET @ExistingDonors = (SELECT Count(RegistryID) FROM DMV_Common.dbo.Registry AS Registry 
						JOIN DMV_Common.dbo.RegistryOwner AS RegistryOwner ON Registry.RegistryOwnerID = RegistryOwner.RegistryOwnerID
						WHERE RegistryOwnerName = 'NORS')

IF @ExistingDonors = 0 
BEGIN
	PRINT 'Start data migration.. '

	/* Turn Off Counts */
	SET NOCOUNT ON

	/* Create Temp Table */
	IF OBJECT_ID('tempdb..#TEMP_Registry') is not null
	BEGIN
		DROP TABLE #TEMP_Registry
	END

		CREATE Table #TEMP_Registry
		(RegistryID int NOT NULL)

	/* Get Registry IDs */
	INSERT INTO #TEMP_Registry (RegistryID)
		(SELECT ID FROM Registry WHERE Donor = 1 AND DonorConfirmed = 1)
	DECLARE @Identity int
	DECLARE @RegistryID int
	DECLARE @RegistryOwnerID int
	DECLARE @LastStatEmployeeID int
	DECLARE @AuditLogTypeID int
	DECLARE @EventCategoryID int
	DECLARE @EventSubCategoryID int

	SET @RegistryOwnerID = (SELECT TOP 1 RegistryOwnerID FROM DMV_Common.dbo.RegistryOwner WHERE RegistryOwnerName = 'NORS')
	SET @LastStatEmployeeID = 1100
	SET @AuditLogTypeID = 1 --Create

	SET @EventCategoryID = (SELECT EventCategoryID FROM DMV_Common.dbo.EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Existing Donors')
	SET @EventSubCategoryID = (SELECT EventSubCategoryID FROM DMV_Common.dbo.EventSubCategory WHERE EventSubCategoryName = 'Nebraska Web Registry')

	WHILE (SELECT Count(RegistryID) FROM #TEMP_Registry) > 0 AND (@EventCategoryID) > 0 AND (@EventSubCategoryID) > 0
	BEGIN
		--BEGIN Transaction TransferDonor
		SET @RegistryID = (SELECT Min(RegistryID) FROM #TEMP_Registry)

			INSERT INTO DMV_Common.dbo.Registry
			(
				RegistryOwnerID,
				SSN,
				DOB,
				FirstName,
				MiddleName,
				LastName,
				Gender,
				Race,
				Phone,
				Email,
				Comment,
				Limitations, 
				License,
				Donor,
				DonorConfirmed,
				OnlineRegDate,
				SignatureDate,
				MailerDate,
				DeleteFlag,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
			SELECT
				@RegistryOwnerID,
				IsNull(SSN, '') AS SSN,
				CASE WHEN DatePart(yyyy, DOB) > '2010' 
					 THEN DateAdd(yyyy,-100, DOB)
					 ELSE DOB END AS DOB,
				IsNull(FirstName, '') AS FirstName,
				IsNull(MiddleName, '') AS MiddleName,
				IsNull(LastName, '') AS LastName,
				IsNull(Gender, 'U') AS Gender,
				IsNull(Race, 0) AS Race,
				IsNull(Phone, '') AS Phone,
				'' AS Email,
				SourceCode AS Comment,
				IsNull(Comment, '') AS Limitations,
				IsNull(License, '') AS License,
				IsNull(Donor, 0), --(not null)
				IsNull(DonorConfirmed, 0), --(not null)
				OnlineRegDate, --OnlineRegDate
				SignatureDate,
				MailerDate, -- MailerDate
				0, --DeleteFlag (not null)
				CreateDate,
				GetDate(), --LastModified,
				@LastStatEmployeeID,
				@AuditLogTypeID
			FROM Registry
			WHERE  ID = @RegistryID
			
		SELECT @Identity = @@Identity

			INSERT INTO DMV_Common.dbo.RegistryAddr
			(
				RegistryID,
				AddrTypeID,
				Addr1,
				City,
				State,
				Zip,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
			SELECT
				@Identity,
				1,
				IsNull(Addr1, '') AS Addr1,
				IsNull(City, '') AS City,
				IsNull(State, '') AS State,
				IsNull(Zip, '') AS Zip,
				CreateDate,
				GetDate(), -- LastModified
				@LastStatEmployeeID,
				@AuditLogTypeID
			FROM RegistryAddr
			WHERE RegistryID = @RegistryID AND AddrTypeID = 1
			
			INSERT INTO DMV_Common.dbo.RegistryAddr
			(
				RegistryID,
				AddrTypeID,
				Addr1,
				City,
				State,
				Zip,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
			SELECT
				@Identity,
				2,
				IsNull(Addr1, '') AS Addr1,
				IsNull(City, '') AS City,
				IsNull(State, '') AS State,
				IsNull(Zip, '') AS Zip,
				CreateDate,
				GetDate(), -- LastModified
				@LastStatEmployeeID,
				@AuditLogTypeID
			FROM RegistryAddr
			WHERE RegistryID = @RegistryID AND AddrTypeID = 2					 

			INSERT INTO DMV_Common.dbo.EventRegistry
			(
				RegistryID,
				EventCategoryID,
				EventSubCategoryID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
			VALUES
			(
				@Identity,
				@EventCategoryID,
				@EventSubCategoryID,
				GetDate(),
				GetDate(),
				@LastStatEmployeeID,
				@AuditLogTypeID
			)
				
		Print 'Processing Registry ID: ' + CAST(@RegistryID AS Varchar) + ' to new ID: ' + CAST(@Identity AS Varchar)
		DELETE #TEMP_Registry WHERE RegistryID = @RegistryID
		
		--COMMIT Transaction TransferDonor
	END
END
ELSE
BEGIN
PRINT 'NEOB Records Exist: Data migration aborted'
END

GO