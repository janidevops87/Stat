/* For Release -
 *	CCRST178 NORS Registry Image change
 *	ccarroll - 01/31/2013              */
USE DMV_Common
GO

DECLARE @RegistryOwnerID int = 4,
		@LastStatEmployeeId int = 1100,
		@UpdateId int = 3
/*** USE FOR TEST ***
	SELECT * FROM dbo.RegistryOwnerEnrollmentText WHERE RegistryOwnerID = 4
	SELECT * FROM dbo.RegistryOwnerStateConfig WHERE RegistryOwnerID = 4
*/
/* NORS Mobile Form */
UPDATE RegistryOwnerEnrollmentText
	SET HeaderImageURL = '~/Register/Dynamic/images/nors_mobile_header.jpg',
		HeaderimageWidth = '204',
		HeaderimageHeight = '113',
		LastModified = GETDATE(),
		LastStatEmployeeID = @LastStatEmployeeId,
		AuditLogTypeID = @UpdateId
	WHERE RegistryOwnerID = @RegistryOwnerID
		  AND PATINDEX('~/Register/Dynamic/images/NOR-LOGO-TAGLINE-CMYK.jpg', HeaderImageURL) > 0
		

/* NORS Enrollment Form */
UPDATE RegistryOwnerEnrollmentText
	SET HeaderImageURL = '~/Register/Dynamic/images/nors_form_header.jpg',
		HeaderimageWidth = '300',
		HeaderimageHeight = '166',
		LastModified = GETDATE(),
		LastStatEmployeeID = @LastStatEmployeeId,
		AuditLogTypeID = @UpdateId
	WHERE RegistryOwnerID = @RegistryOwnerID
		  AND  PATINDEX('~/Register/Dynamic/images/nors_form_header.png', HeaderImageURL) > 0

/* NORS verification Form */
UPDATE RegistryOwnerStateConfig
	SET ContactInformationText = REPLACE(ContactInformationText, 'images/nors_logo.gif', 'images/nors_logo.png'),
		LastModified = GETDATE(),
		LastStatEmployeeID = @LastStatEmployeeId,
		AuditLogTypeID = @UpdateId
	WHERE RegistryOwnerID = @RegistryOwnerID
		  AND PATINDEX('%images/nors_logo.gif%', ContactInformationText) > 0
