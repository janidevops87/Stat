/* Add RegistryOwnerElectronicSignatureText
	ccarroll 02/05/2010 - Added Nevada Donor registry (NDN)
	ccarroll 01/11/2011 - Added Nebraska (NORS)
*/

--USE DMV_Common
--GO

DECLARE @RegistryOwnerID int
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

/*** NDN ***/
/** Add RegistryOwnerElectronicSignatureText (en) language **/
IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = 'en') = 0
BEGIN

	INSERT RegistryOwnerElectronicSignatureText
		(
		RegistryOwnerID,
		LanguageCode,
		LblName,
		LblAddress,		
		LblEmail,
		AddLblConfirmation,
		AddCbxConfirmation,
		AddBtnRegistration,
		AddEmailSubject,
		AddEmailBody,
		AddEmailInvitationSubject,
		AddEmailInvitationBody,
		RemoveLblConfirmation,
		RemoveCbxConfirmation,
		RemoveBtnRegistration,
		RemoveEmailSubject,
		RemoveEmailBody,
		EmailFrom,
		CertificateAuthority,
		FailureMessage,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
		)
	VALUES
		(
		@RegistryOwnerID,
		'en', -- LanguageCode
		'Name:', -- LblName
		'Address:', -- LblAddress		
		'Email:', -- LblEmail
		'To electronically sign your donor registration, check the ''Yes'' box below and click the ''Complete Registration'' button.', -- AddLblConfirmation
		'Yes - I consent to donate my organs and tissues after death in accordance with applicable state law and subject only to the limitations I have noted.', -- AddCbxConfirmation
	 	'Complete Registration', -- AddBtnRegistration
		'Donor Confirmation', -- AddEmailSubject
		'Thank you for making the decision to register as an organ and/or tissue donor.  ' +
		'This email is confirmation of your decision to donate.\r\n' +
		'Should you wish to change your Navada Donor Registry status at any time in the future, ' +
		'please visit www.nvdonor.org .\r\n\r\n' +
		'Please remember that Nevada Donor Registry is an independent registry. Adding or removing yourself ' +
		'from this registry does not change your donor designation status with your state department of motor vehicles.\r\n' +
		'To learn more about organ and tissue donation or to contact us directly, visit www.nvdonor.org.', -- AddEmailBody
		'Donor Family and Friends Invitation', -- AddEmailInvitationSubject
		'Now that you have signed up to be a donor through the Nevada Donor Registry, ' +
		'why don�t you invite your friends and family to join you in giving the gift of life!  ' +
		'Forward the message below and spread the word.\r\n' +
		'---\r\n' +
		'Just a quick note to let you know that I�ve just joined the Nevada Donor Registry ' +
		'at www.nvdonor.org.  It�s an easy way to sign up to be an organ and tissue donor.  ' +
		'Thousands of people die every year because there aren�t enough life-saving organs and now you can do ' +
		'something about it by becoming a donor.  I hope you take a few minutes and make the decision to Donate ' +
		'Life at www.nvdonor.org .\r\n' +
		'Thanks.', -- AddEmailInvitationBody
		'To electronically sign your removal from the donor registry, check the ''Remove'' box below and click the ''Remove Registration'' button.', -- RemoveLblConfirmation
		'Remove me from the Nevada Donor Registry.', -- RemoveCbxConfirmation
		'Remove Registration', -- RemoveBtnRegistration
		'Donor Confirmation', -- RemoveEmailSubject
		'This email is confirmation of your decision to remove yourself from the Nevada Donor Registry.\r\n' +
		'Should you wish to join the Nevada Donor Registry again in the future, please visit www.nvdonor.org .\r\n' +
		'Please remember that Nevada Donor Registry is an independent registry. Adding or removing yourself ' +
		'from this registry does not change your donor designation status with your state department of motor vehicles.\r\n' +
		'To learn more about organ and tissue donation or to contact us directly, visit www.nvdonor.org.', -- RemoveEmailBody
		'register@nvdonor.org', --EmailFrom
		'Certificate Authority: Nevada Donor Network', -- CertificateAuthority
		'Unfortunately, we have been unable to verify your registration information.<br>' +
		'Please contact us directly through <a href="http://www.nvdonor.org/">www.nvdonor.org</a> ' +
		'and we will assist you in your donation registration. Thank you.', -- FailureMessage
		GetDate(), -- LastModified
		1100, -- LastStatEmployeeID
		1 -- AuditLogTypeID
		)
END

/** Add RegistryOwnerElectronicSignatureText (es) language **/
IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = 'es') = 0
BEGIN

	INSERT RegistryOwnerElectronicSignatureText
		(
		RegistryOwnerID,
		LanguageCode,
		LblName,
		LblAddress,		
		LblEmail,
		AddLblConfirmation,
		AddCbxConfirmation,
		AddBtnRegistration,
		AddEmailSubject,
		AddEmailBody,
		AddEmailInvitationSubject,
		AddEmailInvitationBody,
		RemoveLblConfirmation,
		RemoveCbxConfirmation,
		RemoveBtnRegistration,
		RemoveEmailSubject,
		RemoveEmailBody,
		EmailFrom,
		CertificateAuthority,
		FailureMessage,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID

		)
	VALUES
		(
		@RegistryOwnerID,
		'es', -- LanguageCode
		'Nombre:', -- LblName
		'Direcci�n:', -- LblAddress		
		'E-Mail:', -- LblEmail
		'Para ingresar electronicamente su registro de donante, marke '' s� '' n la cajita de abajo ' +
		'y haga clic abajo en "Completar Registraci�n".', -- AddLblConfirmation
		'S� - Conciento donar mis �rganos y tejidos despu�s de la muerte de acuerdo con la Ley aplicable '+
		'al estado y sujeto solamente a las limitaciones que he anotado.', -- AddCbxConfirmation
	 	'Registraci�n Completa', -- AddBtnRegistration
		'Confirmaci�n de donantes', -- AddEmailSubject
		'Gracias por tomar la decisi�n de registrar como un donante de �rganos o tejidos. ' +
		'Este correo electr�nico es la confirmaci�n de su decisi�n de donar.\r\n' +
		'Si usted quisiera cambiar el estatus de su registro de Donate Vida Nevada en cualquier ' +
		'momento en el futuro, por favor visite visite www.nvdonor.org. \r\n\r\n' +
		'Por favor recuerde que Done Vida Nevada es un registro independiente. A�adirse o ' +
		'removerse por usted  mismo de este registro no modificar� el estado de su decisi�n con el ' +
		'departamento de motores y  veh�culos. Para obtener m�s informaci�n sobre la donaci�n de �rganos y ' +
		'tejidos o para ponerse en contacto con nosotros directamente, visite www.nvdonor.org. \r\n\r\n', -- AddEmailBody
		'La familia de donantes y amigos invitaci�n', -- AddEmailInvitationSubject
		'Ahora que ya se ha inscrito para ser un donante a trav�s de Done Vida Nevada �porqu� no invitar ' +
		'a sus amigos y familiares a unirse a usted para dar el regalo de vida! Reenv�e el mensaje a continuaci�n y ' +
		'comparta el mensaje.\r\n' +
		'---\r\n' +
		'S�lo una peque�a nota para hacerle saber que me he unido recientemente a Done Vida Nevada en el Registro de ' +
		'Donantes de www.nvdonor.org. \r\n ' +
		'Gracias.', -- AddEmailInvitationBody
		'Para ingresar electr�nicamente su cancelaci�n de registro de donante, marke la ' +
		'"Cancelar" en la cajita de abajo y haga clic abajo en "Cancelar Registraci�n".',--RemoveLblConfirmation
		'Cancelarme del Registro de Nevada Donor Network', -- RemoveCbxConfirmation
		'Registraci�n Cancelada', -- RemoveBtnRegistration
		'Confirmaci�n de donantes', -- RemoveEmailSubject
		'Este mensaje de correo electr�nico es la confirmaci�n de su decisi�n de quitarse de la Registry.\r\n de donantes de Nevada ' +
		' Si desea unirse al registro de donantes de Nevada vuelva a ocurrir en el futuro, por favor visite www.nvdonor.org. \r\n ' +
		' Por favor, recuerde que el registro de donantes de Nevada es un registro independiente. Agregar o quitar usted mismo ' +
		'de este registro no cambia el estado de la designaci�n de donantes con el departamento de estado de motor vehicles.\r\n' +
		' Para obtener m�s informaci�n acerca de la donaci�n de �rganos y tejidos o ponerse en contacto con nosotros directamente, visite www.nvdonor.org.', -- RemoveEmailBody
		'register@nvdonor.org', --EmailFrom
		'Certificate Authority: Nevada Donor Network', -- CertificateAuthority
		'Lamentablemente, no hemos podido verificar su informaci�n de registro. ' +
		'Por favor p�ngase en contacto con nosotros directamente a <a href="http://www.nvdonor.org/">www.nvdonor.org</a> y le asistiremos con su registro de donante. "Gracias"', -- FailureMessage
		GetDate(), -- LastModified
		1100, -- LastStatEmployeeID
		1 -- AuditLogTypeID
		)
END

/*** NORS ***/
/** Add RegistryOwnerElectronicSignatureText (en) language **/
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 

IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = 'en') = 0
BEGIN

	INSERT RegistryOwnerElectronicSignatureText
		(
		RegistryOwnerID,
		LanguageCode,
		LblName,
		LblAddress,		
		LblEmail,
		AddLblConfirmation,
		AddCbxConfirmation,
		AddBtnRegistration,
		AddEmailSubject,
		AddEmailBody,
		AddEmailInvitationSubject,
		AddEmailInvitationBody,
		RemoveLblConfirmation,
		RemoveCbxConfirmation,
		RemoveBtnRegistration,
		RemoveEmailSubject,
		RemoveEmailBody,
		EmailFrom,
		CertificateAuthority,
		FailureMessage,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
		)
	VALUES
		(
		@RegistryOwnerID,
		'en', -- LanguageCode
		'Name:', -- LblName
		'Address:', -- LblAddress		
		'Email:', -- LblEmail
		'To electronically sign your donor registration, check the ''Yes'' box below and click the ''Complete Registration'' button.', -- AddLblConfirmation
		'Yes - I consent to donate my organs and tissues after death in accordance with applicable state law and subject only to the limitations I have noted.', -- AddCbxConfirmation
	 	'Complete Registration', -- AddBtnRegistration
		'Donor Confirmation', -- AddEmailSubject
		'Thank you for making the decision to register as an organ and/or tissue donor.  ' +
		'This email is confirmation of your decision to donate.\r\n' +
		'Should you wish to change your Donor Registry of Nebraska status at any time in the future, ' +
		'please visit www.nedonation.org .\r\n\r\n' +
		'Please remember that the Donor Registry of Nebraska is an independent registry. Adding or removing yourself ' +
		'from this registry does not change your donor designation status with your state department of motor vehicles.\r\n' +
		'To learn more about organ and tissue donation or to contact us directly, visit www.nedonation.org.', -- AddEmailBody
		'Donor Family and Friends Invitation', -- AddEmailInvitationSubject
		'Now that you have signed up to be a donor through the Donor Registry of Nebraska, ' +
		'why don�t you invite your friends and family to join you in giving the gift of life!  ' +
		'Forward the message below and spread the word.\r\n' +
		'---\r\n' +
		'Just a quick note to let you know that I�ve just joined the Donor Registry of Nebraska ' +
		'at www.nedonation.org.  It�s an easy way to sign up to be an organ and tissue donor.  ' +
		'Thousands of people die every year because there aren�t enough life-saving organs and now you can do ' +
		'something about it by becoming a donor.  I hope you take a few minutes and make the decision to Donate ' +
		'Life at www.nedonation.org .\r\n' +
		'Thanks.', -- AddEmailInvitationBody
		'To electronically sign your removal from the donor registry, check the ''Remove'' box below and click the ''Remove Registration'' button.', -- RemoveLblConfirmation
		'Remove me from the Donor Registry of Nebraska.', -- RemoveCbxConfirmation
		'Remove Registration', -- RemoveBtnRegistration
		'Donor Confirmation', -- RemoveEmailSubject
		'This email is confirmation of your decision to remove yourself from the Donor Registry of Nebraska.\r\n' +
		'Should you wish to join the Donor Registry of Nebraska again in the future, please visit www.nedonation.org .\r\n' +
		'Please remember that the Donor Registry of Nebraska is an independent registry. Adding or removing yourself ' +
		'from this registry does not change your donor designation status with your state department of motor vehicles.\r\n' +
		'To learn more about organ and tissue donation or to contact us directly, visit www.nedonation.org.', -- RemoveEmailBody
		'register@nedonation.org', --EmailFrom
		'Certificate Authority: Donor Registry of Nebraska', -- CertificateAuthority
		'Unfortunately, we have been unable to verify your registration information.<br>' +
		'Please contact us directly through <a href="http://www.nedonation.org/">www.nedonation.org</a> ' +
		'and we will assist you in your donation registration. Thank you.', -- FailureMessage
		GetDate(), -- LastModified
		1100, -- LastStatEmployeeID
		1 -- AuditLogTypeID
		)
END

/** Add NORS RegistryOwnerElectronicSignatureText (es) language **/
IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = 'es') = 0
BEGIN

	INSERT RegistryOwnerElectronicSignatureText
		(
		RegistryOwnerID,
		LanguageCode,
		LblName,
		LblAddress,		
		LblEmail,
		AddLblConfirmation,
		AddCbxConfirmation,
		AddBtnRegistration,
		AddEmailSubject,
		AddEmailBody,
		AddEmailInvitationSubject,
		AddEmailInvitationBody,
		RemoveLblConfirmation,
		RemoveCbxConfirmation,
		RemoveBtnRegistration,
		RemoveEmailSubject,
		RemoveEmailBody,
		EmailFrom,
		CertificateAuthority,
		FailureMessage,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID

		)
	VALUES
		(
		@RegistryOwnerID,
		'es', -- LanguageCode
		'Nombre:', -- LblName
		'Direcci�n:', -- LblAddress		
		'E-Mail:', -- LblEmail
		'Para ingresar electronicamente su registro de donante, marke '' s� '' n la cajita de abajo ' +
		'y haga clic abajo en "Completar Registraci�n".', -- AddLblConfirmation
		'S� - Conciento donar mis �rganos y tejidos despu�s de la muerte de acuerdo con la Ley aplicable '+
		'al estado y sujeto solamente a las limitaciones que he anotado.', -- AddCbxConfirmation
	 	'Completar Registraci�n', -- AddBtnRegistration
		'Confirmaci�n de donantes', -- AddEmailSubject
		'Gracias par tomar la decisi�n de registrar como un donante de �rganos o tejidos. ' +
		'Este correo electr�nico es la confirmaci�n de su decisi�n de donar.\r\n' +
		'Si usted quisiera cambiar el estatus de su registro de Donate Vida Nebraska en cualquier ' +
		'momento en el futuro, por favor visite visite www.nedonation.org. \r\n\r\n' +
		'Por favor recuerde que Done Vida Nevada es un registro independiente. A�adirse o ' +
		'removerse por usted  mismo de este registro no modificar� el estado de su decisi�n con el ' +
		'departamento de motores y  veh�culos. Para obtener m�s informaci�n sobre la donaci�n de �rganos y ' +
		'tejidos o para ponerse en contacto con nosotros directamente, visite www.nedonation.org. \r\n\r\n', -- AddEmailBody
		'La familia de donantes y amigos invitaci�n', -- AddEmailInvitationSubject
		'Ahora que ya se ha inscrito para ser un donante a trav�s de Done Vida Nebraska �porqu� no invitar ' +
		'a sus amigos y familiares a unirse a usted para dar el regalo de vida! Reenv�e el mensaje a continuaci�n y ' +
		'comparta el mensaje.\r\n' +
		'---\r\n' +
		'S�lo una peque�a nota para hacerle saber que me he unido recientemente a Done Vida Nebraska en el Registro de ' +
		'Donantes de www.nedonation.org. \r\n ' +
		'Gracias.', -- AddEmailInvitationBody
		'Para ingresar electr�nicamente su cancelaci�n de registro de donante, marke la ' +
		'"Cancelar" en la cajita de abajo y haga clic abajo en "Cancelar Registraci�n".',--RemoveLblConfirmation
		'Cancelarme del Registro de Donor Network of Nebraska', -- RemoveCbxConfirmation
		'Registraci�n Cancelada', -- RemoveBtnRegistration
		'Confirmaci�n de donantes', -- RemoveEmailSubject
		'Este mensaje de correo electr�nico es la confirmaci�n de su decisi�n de quitarse del Registro de donantes de Nebraska.\r\n ' +
		' Si desea unirse al registro de donantes de Nebraska vuelva a ocurrir en el futuro, por favor visite www.nedonation.org.\r\n ' +
		' Por favor, recuerde que el registro de donantes de Nebraska es un registro independiente. Agregar o quitar usted mismo ' +
		'de este registro no cambia el estado de la designaci�n de donantes con el departamento de estado de motor vehicles.\r\n' +
		' Para obtener m�s informaci�n sobre de la donaci�n de �rganos y tejidos o para ponerse en contacto con nosotros directamente, visite www.nedonation.org.', -- RemoveEmailBody
		'register@nedonation.org', --EmailFrom
		'Certificate Authority: Donor Registry of Nebraska', -- CertificateAuthority
		'Lamentablemente, no hemos podido verificar su informaci�n de registro. ' +
		'Por favor p�ngase en contacto con nosotros directamente a <a href="http://www.nedonation.org/">www.nedonation.org</a> y le asistiremos con su registro de donante. "Gracias"', -- FailureMessage
		GetDate(), -- LastModified
		1100, -- LastStatEmployeeID
		1 -- AuditLogTypeID
		)
END


GO