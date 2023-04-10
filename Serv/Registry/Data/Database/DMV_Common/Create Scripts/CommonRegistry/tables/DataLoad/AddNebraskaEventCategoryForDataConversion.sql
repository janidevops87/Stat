 /*** Nebraska Donor Network ***
		ccarroll - 01/11/2011 	
		Filename: AddNebraskaEventCategoryForDataConversion.sql
		Description: Add Nebraska EventCagetory and EventSubCategory for data conversion.
		Revisions:
		01/25/2011, ccarroll - Added Event Category per client request wi:9693
		
		 
*/
DECLARE @RegistryOwnerID int
SET @RegistryOwnerID =(SELECT TOP 1 RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS')

/* Add EventCategory */
IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Existing Donors') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'Existing Donors', --EventCategoryName
			0, --EventCategoryActive
			0, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END

IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Donor Family Reception') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'Donor Family Reception', --EventCategoryName
			1, --EventCategoryActive
			0, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END


IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Omaha Storm Chasers Game') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'Omaha Storm Chasers Game', --EventCategoryName
			1, --EventCategoryActive
			0, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END


IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Cox Classic') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'Cox Classic', --EventCategoryName
			1, --EventCategoryActive
			0, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END


IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Health Fair') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'Health Fair', --EventCategoryName
			1, --EventCategoryActive
			1, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END


IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Life-a-thon') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'Life-a-thon', --EventCategoryName
			1, --EventCategoryActive
			0, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END


IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'SAC-Collaborative event') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'SAC-Collaborative event', --EventCategoryName
			1, --EventCategoryActive
			0, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END


IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'FCCLA Meeting') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'FCCLA Meeting', --EventCategoryName
			1, --EventCategoryActive
			0, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END


IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Other') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'Other', --EventCategoryName
			1, --EventCategoryActive
			1, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END


IF (SELECT Count(*) FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Hospital') = 0
BEGIN 
	INSERT EventCategory
		(
			RegistryOwnerID,
			EventCategoryName,
			EventCategoryActive,
			EventCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			'Hospital', --EventCategoryName
			1, --EventCategoryActive
			0, --EventCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeID
			1 --AuditLogTypeID (Create)
		)
END


/*** START EventSubCategory Add ***/
DECLARE @EventCategoryID int

SET @EventCategoryID = (SELECT EventCategoryID FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Existing Donors')

/* Add Existing Donors SubCategory */
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = 'Nebraska Web Registry' ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			'Nebraska Web Registry', --EventSubCategoryName
			'', --EventSubCategorySourceCode
			0,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END





/* Add Hospitals to SubCategory */
SET @EventCategoryID = (SELECT EventCategoryID FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Hospital')
DECLARE @EventSubCategoryName varchar(255)

SET @EventSubCategoryName = 'Alegent Health'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Annie Jeffrey Memorial County Health Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Antelope Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Aurora Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Avera St. Anthony''s Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Beatrice Community Hospital and Health Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Bellevue Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Blair Memorial Community Hospital & Health System'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Boone County Health Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Box Butte General Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Boystown Reasearch Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Brodstone Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Brown County Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Bryan LGH Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Butler County Health Care Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Callaway District Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Chadron Community Hospital & Health Services'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Chase County Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Cherry County Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Children''s Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Columbus Community Hospital, Inc.'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Cozad Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Creighton Area Health Services'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Creighton University Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Crete Area Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Dundy County Health System'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Faith Regional Health Services'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Falls City Community Medical Center, Inc.'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Fillmore County Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Franklin County Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Fremont Area Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Garden County Health Services'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Genoa Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Good Samaritan Health Systems'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Gordon Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Gothenburg Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Great Plains Regional Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Harlan County Health System'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Henderson Health Care Services, Inc.'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Howard County Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Jefferson Community Health Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Jennie M. Melham Memorial Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Johnson County Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Kearney County Health Services'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Kimball Health Services'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Litzenberg Memorial County Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Madonna Rehabilitation Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'Mary Lanning Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


SET @EventSubCategoryName = 'McCook Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Methodist Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Midwest Surgical Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Morrill County Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Nebraska Heart Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Nebraska Orthopedic Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Nebraska Spine Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Nemaha County Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Niobrara Valley Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Norfolk Regional Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Oakland Mercy Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Ogallala Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Osmond General Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Pawnee County Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Pender Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Perkins County Health Services'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Phelps Memorial Health Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Plainview Area Health System'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Providence Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Regional West Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Richard Young (Kearney)'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Rock County Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Saint Elizabeth Regional Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Saint Francis Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Saint Francis Memorial Hospital (West Point)'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Saint Mary''s Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Saunders County Health Services'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Select Specialty Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Seward Memorial Health Care Systems'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Sidney Memorial Health Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Syracuse Community Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Thayer County Health Services'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'The Nebraska Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Tilden Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Tri County Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Tri Valley Health System'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'US Public Health Service'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Valley County Health System'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Veterans Affairs Medical Center'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Warren Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'Webster County Community Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'West Holt Memorial Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END

SET @EventSubCategoryName = 'York General Hospital'
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = @EventSubCategoryName ) = 0
BEGIN 
	INSERT EventSubCategory
		(
			EventCategoryID,
			EventSubCategoryName,
			EventSubCategorySourceCode,
			EventSubCategoryActive,
			EventSubCategorySpecifyText,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@EventCategoryID,
			@EventSubCategoryName, --EventSubCategoryName
			'', --EventSubCategorySourceCode
			1,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


GO 