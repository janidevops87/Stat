/* AddRegistryOwnerUserOrg
	ccarroll 06/28/2011 - Initial, Moved to new sproc, added:
	 425	NE- Lions Eye Bank of Nebraska
	
*/

DECLARE @RegistryOwnerID int

/*** Add RegistryOwnerUserOrgID ***/
IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 4853) = 0
BEGIN
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				4853, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 14360) = 0
BEGIN /* University of Nevada School of Medicine */
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				14360, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 4237) = 0
BEGIN /*CA- Calif Transplant Donor Network (Organs)*/
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				4237, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 4243) = 0
BEGIN /*CA- Golden State Donor Services (Organs)*/
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				4243, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 4236) = 0
BEGIN /*CA- Sierra Eye & Tissue Donor Services*/
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				4236, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 10645) = 0
BEGIN /* UT- Intermountain Donor Services */
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				10645, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 4321) = 0
BEGIN /* CT- LifeChoice Donor Services */
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				4321, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 4322) = 0
BEGIN /* CT- Connecticut Eye Bank */
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				4322, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 5745) = 0
BEGIN /* NY- Center for Donation & Transplant */
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				5745, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

/* Nebraska Organ Recovery System (NORS)*/
IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 423	) = 0
BEGIN /* NE- A Nebraska Organ Recovery System */
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				423, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END


/* Nebraska Organ Recovery System (NORS)*/
IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 425	) = 0
BEGIN /* NE- Lions Eye Bank of Nebraska */
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				425, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

/* CO- Rocky Mountain Lions Eye Bank*/
IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 99	) = 0
BEGIN /* CO- Rocky Mountain Lions Eye Bank */
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'CODA') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				99, 
				GetDate(),
				GetDate(),
				1100,
				1
			)
END

GO