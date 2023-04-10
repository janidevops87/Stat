  /* Update (NDN) RegistryOwnerEnrollmentText
	FileName: UpdateNVRegistryOwnerEnrollmentText.sql 
	 -------------------------------
	02/29/2012 ccarroll - initial
	03/13/2012 ccarroll - Added note for release CCRST168
	Description: This script updates contact information on the enrollment and verification forms.
*/

/*** Nevada (NDN) - Update  RegistryOwnerEnrollmentText en ***/
DECLARE @ID Int,
		@ExistingContactNumber nvarchar(100) = '775-323-1566',
		@OldContactName nvarchar(200) = 'Sierra Eye Tissue Donor Services</td><td></td></tr><tr><td>775-323-1566',
		@NewContactName nvarchar(200) = 'Sierra Donor Services</td><td></td></tr><tr><td>877-401-2546',
		@RegistryOwnerName nvarchar(100),
		@RegistryOwnerID int

SET @RegistryOwnerName = 'NDN'

SET @ID = (SELECT TOP 1 ID FROM RegistryOwnerEnrollmentText
			JOIN RegistryOwner ON RegistryOwner.RegistryOwnerID = RegistryOwnerEnrollmentText.RegistryOwnerID 
			WHERE RegistryOwnerName = @RegistryOwnerName AND LanguageCode='en'
			)

IF (SELECT Count(*) FROM RegistryOwnerEnrollmentText WHERE ID = @ID AND PATINDEX('%' + @ExistingContactNumber +'%', DivInformationContacts) > 0) > 0 
BEGIN
PRINT 'Updating NDN Enrollment form Text for en..'
	UPDATE RegistryOwnerEnrollmentText
	SET 
		DivInformationContacts =  REPLACE(DivInformationContacts, @OldContactName, @NewContactName),
		LastModified = GetDate(),
		LastStatEmployeeID = 1100,
		AuditLogTypeID = 3
	WHERE ID = @ID
END

/*** Nevada (NDN) - Update  RegistryOwnerEnrollmentText es ***/
SET @ID = (SELECT TOP 1 ID FROM RegistryOwnerEnrollmentText
			JOIN RegistryOwner ON RegistryOwner.RegistryOwnerID = RegistryOwnerEnrollmentText.RegistryOwnerID 
			WHERE RegistryOwnerName = @RegistryOwnerName AND LanguageCode='es'
			)

IF (SELECT Count(*) FROM RegistryOwnerEnrollmentText WHERE ID = @ID AND PATINDEX('%' + @ExistingContactNumber +'%', DivInformationContacts) > 0) > 0 
BEGIN
PRINT 'Updating NDN Enrollment form Text for es..'
	UPDATE RegistryOwnerEnrollmentText
	SET 
		DivInformationContacts =  REPLACE(DivInformationContacts, @OldContactName, @NewContactName),
		LastModified = GetDate(),
		LastStatEmployeeID = 1100,
		AuditLogTypeID = 3
	WHERE ID = @ID
END

/*** Nevada (NDN) - Update  RegistryOwnerStateConfig es ***/

SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName) 
SET @OldContactName = '<strong>Sierra Eye Tissue Donor Services</strong</td><td></td></tr><tr><td><strong>775-323-1566</strong>'
SET	@NewContactName = '<strong>Sierra Donor Services</strong</td><td></td></tr><tr><td><strong>877-401-2546</strong>'

IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerId = @RegistryOwnerID AND PATINDEX('%' + @ExistingContactNumber +'%', ContactInformationText) > 0) > 0 
BEGIN
PRINT 'Updating NDN RegistryOwnerStateConfig (verification form) text..'
	UPDATE RegistryOwnerStateConfig
	SET 
		ContactInformationText =  REPLACE(ContactInformationText, @OldContactName, @NewContactName),
		LastModified = GetDate(),
		LastStatEmployeeID = 1100,
		AuditLogTypeID = 3
	WHERE RegistryOwnerID = @RegistryOwnerID
END
/*** End  Updates ***/

