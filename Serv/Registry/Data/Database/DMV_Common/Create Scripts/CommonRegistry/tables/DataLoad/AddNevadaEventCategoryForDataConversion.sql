/*** Nevada Donor Network ***
		ccarroll - 03/04/2010 	
		Filename: AddNevadaEventCategoryForDataConversion.sql
		Description: Add Nevada EventCagetory and EventSubCategory for data conversion. 
***/
DECLARE @RegistryOwnerID int
SET @RegistryOwnerID =(SELECT TOP 1 RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN')

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

DECLARE @EventCategoryID int
SET @EventCategoryID = (SELECT EventCategoryID FROM EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryName = 'Existing Donors')

/* Add EventSubCategory */
IF (SELECT Count(*) FROM EventSubCategory WHERE EventCategoryID = @EventCategoryID AND EventSubCategoryName = 'Nevada Web Registry' ) = 0
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
			'Nevada Web Registry', --EventSubCategoryName
			'', --EventSubCategorySourceCode
			0,  --EventSubCategoryActive
			0,  --EventSubCategorySpecifyText
			GetDate(), --CreateDate
			GetDate(), --LastModified
			1100, --LastStatEmployeeId
			1 --AuditLogTypeID (Create)
		)
END


GO 