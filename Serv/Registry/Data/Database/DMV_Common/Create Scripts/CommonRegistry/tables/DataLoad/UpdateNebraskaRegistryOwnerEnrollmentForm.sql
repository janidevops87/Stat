 /* Update (NORS)RegistryOwnerEnrollmentText
	FileName: UpdateNebraskaRegistryOwnerEnrollmentForm.sql 
	 -------------------------------
	3/22/2011 ccarroll - initial
	Description: remove Span tags and replace with <h2> header tags. Color and font are now handeled in CSS file.
*/

/*** Nebraska (NORS) - Update  RegistryOwnerEnrollmentForm en ***/
DECLARE @ID Int

SET @ID = (SELECT TOP 1 ID FROM RegistryOwnerEnrollmentText
			JOIN RegistryOwner ON REgistryOwner.RegistryOwnerID = RegistryOwnerEnrollmentText.RegistryOwnerID 
			WHERE RegistryOwnerName = 'NORS' AND LanguageCode='en'
			)

IF (SELECT Count(*) FROM RegistryOwnerEnrollmentText WHERE ID = @ID AND DivRegistrationSelection LIKE '%color:green%') > 0
BEGIN
PRINT 'Updating NORS Enrollment Text for en..'
UPDATE RegistryOwnerEnrollmentText
SET 
	DivRegistrationSelection = '<h2>Donor Information</h2><p>Fields marked with a <span style=''color:red;''>*</span> are required.</p>',
	DivResidentialAddress = '<h2>Residential Address</h2>',
	DivContactInformation = '<h2>Contact Information</h2>',
	DivLimitations = '<h2>Donor Restrictions</h2>',
	LblEventCategoryMessage = '<h2>Other Information</h2><span style=''color:red;''>* </span>How did you hear about us?',
	DivFooter = '<div id=''ft''><div class=''wrapper''><div class=''inner''><div class=''copyright''><strong>Nebraska Organ Recovery System (NORS) is a Donate Life Organization</strong><br />For more information <a href=''http://www.nedonation.org/''>Contact NORS</a> at 402-733-1800</div></div></div></div>',
	LastModified = GetDate(),
	LastStatEmployeeID = 1100,
	AuditLogTypeID = 3
WHERE ID = @ID
END


SET @ID = (SELECT TOP 1 ID FROM RegistryOwnerEnrollmentText
			JOIN RegistryOwner ON REgistryOwner.RegistryOwnerID = RegistryOwnerEnrollmentText.RegistryOwnerID 
			WHERE RegistryOwnerName = 'NORS' AND LanguageCode='es'
			)

IF (SELECT Count(*) FROM RegistryOwnerEnrollmentText WHERE ID = @ID AND DivRegistrationSelection LIKE '%color:green%') > 0
BEGIN
PRINT 'Updating NORS Enrollment Text for es..'
UPDATE RegistryOwnerEnrollmentText
SET 
	DivRegistrationSelection = N'<h2>Información del donante</h2><div>Los campos marcados con un <span style=''color:red;''>*</span>se requieren.</div>',
	DivResidentialAddress = N'<h2>Dirección Residencial</h2>',
	DivContactInformation = N'<h2>información de Contacto</h2>',
	DivLimitations = N'<h2>Restricciones de los donantes</h2>',
	LblEventCategoryMessage = N'<h2>Otra información</h2><span style=''color:red;''>* </span>¿Cómo se enteró de nosotros?',
	DivFooter = N'<div id=''ft''><div class=''wrapper''><div class=''inner''><div class=''copyright''><strong>Nebraska Organ Recovery System (NORS) is a Donate Life Organization</strong><br />For more information <a href=''http://www.nedonation.org/''>Contact NORS</a> at 402-733-1800</div></div></div></div>',
	LastModified = GetDate(),
	LastStatEmployeeID = 1100,
	AuditLogTypeID = 3
WHERE ID = @ID
END

/*** End NORS Enrollment Text Updates ***/
GO

