  /* Update (NORS) RegistryOwnerElectronicSignatureText
	FileName: UpdateNebraskaRegistryOwnerSignatureText.sql 
	 -------------------------------
	3/22/2011 ccarroll - initial
	Description: This script updates the DivFooter column with NORS footer information.
				 The Electronic Signature footer is loaded at runtime when GetRegistryOwnerElectronicSignatureText
				 is called. The footer may be customized specifically for the electronic
				 signature page.
*/

/*** Nebraska (NORS) - Update  RegistryOwnerElectronicSignatureText en ***/
DECLARE @ID Int

SET @ID = (SELECT TOP 1 ID FROM RegistryOwnerElectronicSignatureText
			JOIN RegistryOwner ON REgistryOwner.RegistryOwnerID = RegistryOwnerElectronicSignatureText.RegistryOwnerID 
			WHERE RegistryOwnerName = 'NORS' AND LanguageCode='en'
			)

IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE ID = @ID AND LEN(Isnull(DivFooter, '')) = 0) > 0 --AND LEN(DivFooter)) > 0 
BEGIN
PRINT 'Updating NORS Electronic Signature Text for en..'
	UPDATE RegistryOwnerElectronicSignatureText
	SET 
		DivFooter = '<div id=''ft''><div class=''wrapper''><div class=''inner''><div class=''copyright''><strong>Nebraska Organ Recovery System (NORS) is a Donate Life Organization</strong><br />For more information <a href=''http://www.nedonation.org/''>Contact NORS</a> at 402-733-1800</div></div></div></div>',
		LastModified = GetDate(),
		LastStatEmployeeID = 1100,
		AuditLogTypeID = 3
	WHERE ID = @ID
END

SET @ID = (SELECT TOP 1 ID FROM RegistryOwnerElectronicSignatureText
			JOIN RegistryOwner ON REgistryOwner.RegistryOwnerID = RegistryOwnerElectronicSignatureText.RegistryOwnerID 
			WHERE RegistryOwnerName = 'NORS' AND LanguageCode='es'
			)

IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE ID = @ID AND LEN(Isnull(DivFooter, '')) = 0) > 0 --AND LEN(DivFooter)) > 0 
BEGIN
PRINT 'Updating NORS Electronic Signature Text for es..'
	UPDATE RegistryOwnerElectronicSignatureText
	SET 
		DivFooter = N'<div id=''ft''><div class=''wrapper''><div class=''inner''><div class=''copyright''><strong>Nebraska Organ Recovery System (NORS) is a Donate Life Organization</strong><br />For more information <a href=''http://www.nedonation.org/''>Contact NORS</a> at 402-733-1800</div></div></div></div>',
		LastModified = GetDate(),
		LastStatEmployeeID = 1100,
		AuditLogTypeID = 3
	WHERE ID = @ID
END

/*** End NORS Electronic Signature Text Updates ***/
GO

