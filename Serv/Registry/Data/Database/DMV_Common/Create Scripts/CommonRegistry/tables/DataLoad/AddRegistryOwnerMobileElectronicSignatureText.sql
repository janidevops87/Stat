﻿/*
	AddRegistryOwnerMobileElectronicSignatureText
	Filename :AddRegistryOwnerMobileElectronicSignatureText.sql
	Description: 
			1. Updates for registry Mobile content including:
			 a. RegistryOwnerElectronicSignatureText
	-------------------------------------------------------
	**		02/28/2012	ccarroll	Initial
	**		03/13/2012  ccarroll	Added for inclusion in release
	**		02/28/2014	Moonray Schepart	Merged into RegistryOwnerElectronicSignatureText.sql in CommonRegistry Create Scripts
*/

--USE DMV_Common
--GO

PRINT 'AddRegistryOwnerMobileElectronicSignatureText.sql Has Been Merged Into RegistryOwnerElectronicSignatureText.sql As Of: 2/28/2014';

--DECLARE @RegistryOwnerName varchar(100),
--		@RegistryOwnerID int,
--		@MobileContentCode nvarchar(2)
		
--/*** NEOB **/		 
--SET @RegistryOwnerName = 'NEOB'
--SET @MobileContentCode = 'm'
--SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName) 

--/*** NEOB ***/
--/** Add RegistryOwnerElectronicSignatureText (md) Mobile content **/
--IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = @MobileContentCode) = 0
--BEGIN
--	PRINT 'Adding Mobile Electronic Signature Text: ' + @RegistryOwnerName
--	INSERT RegistryOwnerElectronicSignatureText
--		(
--		RegistryOwnerID,
--		LanguageCode,
--		LblName,
--		LblAddress,		
--		LblEmail,
--		AddLblConfirmation,
--		AddCbxConfirmation,
--		AddBtnRegistration,
--		AddEmailSubject,
--		AddEmailBody,
--		AddEmailInvitationSubject,
--		AddEmailInvitationBody,
--		RemoveLblConfirmation,
--		RemoveCbxConfirmation,
--		RemoveBtnRegistration,
--		RemoveEmailSubject,
--		RemoveEmailBody,
--		EmailFrom,
--		CertificateAuthority,
--		FailureMessage,
--		LastModified,
--		LastStatEmployeeID,
--		AuditLogTypeID
--		)
--	VALUES
--		(
--		@RegistryOwnerID,
--		@MobileContentCode, -- LanguageCode
--		'Name:', -- LblName
--		'Address:', -- LblAddress		
--		'Email:', -- LblEmail
--		'To electronically sign your donor registration, check the ''Yes'' box below and click the ''Complete Registration'' button.', -- AddLblConfirmation
--		'Yes - I consent to donate my organs and tissues after death in accordance with applicable state law and subject only to the limitations I have noted.', -- AddCbxConfirmation
--	 	'Complete Registration', -- AddBtnRegistration
--		'Donor Confirmation', -- AddEmailSubject
--		'Thank you for making the decision to register as an organ and/or tissue donor.  ' +
--		'This email is confirmation of your decision to donate.\r\n' +
--		'Should you wish to change your Donate Life New England Donor Registry status at ' +
--        'any time in the future, please visit www.donatelifenewengland.org\r\n\r\n' +
--		'Please remember that Donate Life New England is an independent registry. Adding '+
--        'or removing yourself from this registry does not change your donor designation status ' +
--        'with your state department of motor vehicles in any way.\r\n' +
--		'To learn more about organ and tissue donation or to contact us directly, visit www.donatelifenewengland.org.', -- AddEmailBody
--		'Donor Family and Friends Invitation', -- AddEmailInvitationSubject
--		'Now that you have signed up to be a donor through the Donate Life New England Donor Registry, ' +
--		'why don’t you invite your friends and family to join you in giving the gift of life!  ' +
--		'Forward the message below and spread the word.\r\n' +
--		'---\r\n' +
--		'Just a quick note to let you know that I’ve just joined the Donate Life New England Donor Registry ' +
--		'at www.donatelifenewengland.org.  It’s an easy way to sign up to be an organ and tissue donor.  ' +
--		'Thousands of people die every year because there aren’t enough life-saving organs and now you can do ' +
--		'something about it by becoming a donor.  I hope you take a few minutes and make the decision to Donate ' +
--		'Life at www.donatelifenewengland.org.\r\n' +
--		'Thanks.', -- AddEmailInvitationBody
--		'To electronically sign your removal from the donor registry, check the ''Remove'' box below and click the ''Remove Registration'' button.', -- RemoveLblConfirmation
--		'Remove me from the Donate Life New England Donor Registry.', -- RemoveCbxConfirmation
--		'Remove Registration', -- RemoveBtnRegistration
--		'Donor Confirmation', -- RemoveEmailSubject
--		'This email is confirmation of your decision to remove yourself from the Donate Life New England Donor Registry.\r\n' +
--		'Should you wish to join the Donate Life New England Donor Registry again in the future, please visit www.donatelifenewengland.org.\r\n' +
--		'Please remember that Donate Life New England is an independent registry. Adding or removing yourself ' +
--		'from this registry does not change your donor designation status with your state department of motor vehicles.\r\n' +
--		'To learn more about organ and tissue donation or to contact us directly, visit www.donatelifenewengland.org.', -- RemoveEmailBody
--		'register@donatelifenewengland.org', --EmailFrom
--		'Certificate Authority: Donate Life New England', -- CertificateAuthority
--		'Unfortunately, we have been unable to verify your registration information.<br>' +
--		'Please contact us directly through  <a href="http://www.donatelifenewengland.org/">www.donatelifenewengland.org</a> ' +
--		'and we will assist you in your donation registration. Thank you.', -- FailureMessage
--		GetDate(), -- LastModified
--		1100, -- LastStatEmployeeID
--		1 -- AuditLogTypeID
--		)
--END

/** MOBILE CODE MERGED INTO RegistryOwnerElectronicSignatureText.sql file **/
/*** NDN **/		 
--SET @RegistryOwnerName = 'NDN'
--SET @MobileContentCode = 'm'
--SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName) 
--/** Add RegistryOwnerElectronicSignatureText (m) Mobile content **/
--IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = @MobileContentCode) = 0
--BEGIN
--	PRINT 'Adding Mobile Electronic Signature Text: ' + @RegistryOwnerName
--	INSERT RegistryOwnerElectronicSignatureText
--		(
--		RegistryOwnerID,
--		LanguageCode,
--		LblName,
--		LblAddress,		
--		LblEmail,
--		AddLblConfirmation,
--		AddCbxConfirmation,
--		AddBtnRegistration,
--		AddEmailSubject,
--		AddEmailBody,
--		AddEmailInvitationSubject,
--		AddEmailInvitationBody,
--		RemoveLblConfirmation,
--		RemoveCbxConfirmation,
--		RemoveBtnRegistration,
--		RemoveEmailSubject,
--		RemoveEmailBody,
--		EmailFrom,
--		CertificateAuthority,
--		FailureMessage,
--		LastModified,
--		LastStatEmployeeID,
--		AuditLogTypeID
--		)
--	VALUES
--		(
--		@RegistryOwnerID,
--		@MobileContentCode, -- LanguageCode
--		'Name:', -- LblName
--		'Address:', -- LblAddress		
--		'Email:', -- LblEmail
--		'To electronically sign your donor registration, check the ''Yes'' box below and click the ''Complete Registration'' button.', -- AddLblConfirmation
--		'Yes - I consent to donate my organs and tissues after death in accordance with applicable state law and subject only to the limitations I have noted.', -- AddCbxConfirmation
--	 	'Complete Registration', -- AddBtnRegistration
--		'Donor Confirmation', -- AddEmailSubject
--		'Thank you for making the decision to register as an organ and/or tissue donor.  ' +
--		'This email is confirmation of your decision to donate.\r\n' +
--		'Should you wish to change your Nevada Donor Registry status at ' +
--        'any time in the future, please visit www.nvdonor.org\r\n\r\n' +
--		'Please remember that Nevada Donor Registry is an independent registry. Adding '+
--        'or removing yourself from this registry does not change your donor designation status ' +
--        'with your state department of motor vehicles in any way.\r\n' +
--		'To learn more about organ and tissue donation or to contact us directly, visit www.nvdonor.org.', -- AddEmailBody
--		'Donor Family and Friends Invitation', -- AddEmailInvitationSubject
--		'Now that you have signed up to be a donor through the Nevada Donor Registry, ' +
--		'why don’t you invite your friends and family to join you in giving the gift of life!  ' +
--		'Forward the message below and spread the word.\r\n' +
--		'---\r\n' +
--		'Just a quick note to let you know that I’ve just joined the Nevada Donor Registry ' +
--		'at www.nvdonor.org.  It’s an easy way to sign up to be an organ and tissue donor.  ' +
--		'Thousands of people die every year because there aren’t enough life-saving organs and now you can do ' +
--		'something about it by becoming a donor.  I hope you take a few minutes and make the decision to Donate ' +
--		'Life at www.nvdonor.org.\r\n' +
--		'Thanks.', -- AddEmailInvitationBody
--		'To electronically sign your removal from the donor registry, check the ''Remove'' box below and click the ''Remove Registration'' button.', -- RemoveLblConfirmation
--		'Remove me from the Nevada Donor Registry.', -- RemoveCbxConfirmation
--		'Remove Registration', -- RemoveBtnRegistration
--		'Donor Confirmation', -- RemoveEmailSubject
--		'This email is confirmation of your decision to remove yourself from the Nevada Donor Registry.\r\n' +
--		'Should you wish to join the Nevada Donor Registry again in the future, please visit www.nvdonor.org.\r\n' +
--		'Please remember that Nevada Donor Registry is an independent registry. Adding or removing yourself ' +
--		'from this registry does not change your donor designation status with your state department of motor vehicles.\r\n' +
--		'To learn more about organ and tissue donation or to contact us directly, visit www.nvdonor.org.', -- RemoveEmailBody
--		'register@nvdonor.org', --EmailFrom
--		'Certificate Authority: Nevada Donor Registry', -- CertificateAuthority
--		'Unfortunately, we have been unable to verify your registration information.<br>' +
--		'Please contact us directly through  <a href="http://www.nvdonor.org/">www.nvdonor.org</a> ' +
--		'and we will assist you in your donation registration. Thank you.', -- FailureMessage
--		GetDate(), -- LastModified
--		1100, -- LastStatEmployeeID
--		1 -- AuditLogTypeID
--		)
--END


/** MOBILE CODE MERGED INTO RegistryOwnerElectronicSignatureText.sql file **/
--/*** NORS **/		 
--SET @RegistryOwnerName = 'NORS'
--SET @MobileContentCode = 'm'
--SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName) 


--/** Add RegistryOwnerElectronicSignatureText (m) Mobile content **/
--IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = @MobileContentCode) = 0
--BEGIN
--	PRINT 'Adding Mobile Electronic Signature Text: ' + @RegistryOwnerName
--	INSERT RegistryOwnerElectronicSignatureText
--		(
--		RegistryOwnerID,
--		LanguageCode,
--		LblName,
--		LblAddress,		
--		LblEmail,
--		AddLblConfirmation,
--		AddCbxConfirmation,
--		AddBtnRegistration,
--		AddEmailSubject,
--		AddEmailBody,
--		AddEmailInvitationSubject,
--		AddEmailInvitationBody,
--		RemoveLblConfirmation,
--		RemoveCbxConfirmation,
--		RemoveBtnRegistration,
--		RemoveEmailSubject,
--		RemoveEmailBody,
--		EmailFrom,
--		CertificateAuthority,
--		FailureMessage,
--		LastModified,
--		LastStatEmployeeID,
--		AuditLogTypeID
--		)
--	VALUES
--		(
--		@RegistryOwnerID,
--		@MobileContentCode, -- LanguageCode
--		'Name:', -- LblName
--		'Address:', -- LblAddress		
--		'Email:', -- LblEmail
--		'To electronically sign your donor registration, check the ''Yes'' box below and click the ''Complete Registration'' button.', -- AddLblConfirmation
--		'Yes - I consent to donate my organs and tissues after death in accordance with applicable state law and subject only to the limitations I have noted.', -- AddCbxConfirmation
--	 	'Complete Registration', -- AddBtnRegistration
--		'Donor Confirmation', -- AddEmailSubject
--		'Thank you for making the decision to register as an organ and/or tissue donor.  ' +
--		'This email is confirmation of your decision to donate.\r\n' +
--		'Should you wish to change your Donor Registry of Nebraska status at ' +
--        'any time in the future, please visit www.nedonation.org\r\n\r\n' +
--		'Please remember that the Donor Registry of Nebraska is an independent registry. Adding '+
--        'or removing yourself from this registry does not change your donor designation status ' +
--        'with your state department of motor vehicles in any way.\r\n' +
--		'To learn more about organ and tissue donation or to contact us directly, visit www.nedonation.org.', -- AddEmailBody
--		'Donor Family and Friends Invitation', -- AddEmailInvitationSubject
--		'Now that you have signed up to be a donor through the Donor Registry of Nebraska, ' +
--		'why don’t you invite your friends and family to join you in giving the gift of life!  ' +
--		'Forward the message below and spread the word.\r\n' +
--		'---\r\n' +
--		'Just a quick note to let you know that I’ve just joined the Donor Registry of Nebraska ' +
--		'at www.nedonation.org.  It’s an easy way to sign up to be an organ and tissue donor.  ' +
--		'Thousands of people die every year because there aren’t enough life-saving organs and now you can do ' +
--		'something about it by becoming a donor.  I hope you take a few minutes and make the decision to Donate ' +
--		'Life at www.nedonation.org.\r\n' +
--		'Thanks.', -- AddEmailInvitationBody
--		'To electronically sign your removal from the donor registry, check the ''Remove'' box below and click the ''Remove Registration'' button.', -- RemoveLblConfirmation
--		'Remove me from the Donor Registry of Nebraska.', -- RemoveCbxConfirmation
--		'Remove Registration', -- RemoveBtnRegistration
--		'Donor Confirmation', -- RemoveEmailSubject
--		'This email is confirmation of your decision to remove yourself from the Donor Registry of Nebraska.\r\n' +
--		'Should you wish to join the Donor Registry of Nebraska again in the future, please visit www.nedonation.org.\r\n' +
--		'Please remember that the Donor Registry of Nebraska is an independent registry. Adding or removing yourself ' +
--		'from this registry does not change your donor designation status with your state department of motor vehicles.\r\n' +
--		'To learn more about organ and tissue donation or to contact us directly, visit www.nedonation.org.', -- RemoveEmailBody
--		'register@nedonation.org', --EmailFrom
--		'Certificate Authority: Donor Registry of Nebraska', -- CertificateAuthority
--		'Unfortunately, we have been unable to verify your registration information.<br>' +
--		'Please contact us directly through  <a href="http://www.nedonation.org/">www.nedonation.org</a> ' +
--		'and we will assist you in your donation registration. Thank you.', -- FailureMessage
--		GetDate(), -- LastModified
--		1100, -- LastStatEmployeeID
--		1 -- AuditLogTypeID
--		)
--END


/*** CODA **/		 

--SET @RegistryOwnerName = 'CODA';
--SET @MobileContentCode = 'm'; -- Mobile content for Colorado
--SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName) ;

--/** Add RegistryOwnerElectronicSignatureText (m) Mobile content **/
--IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = @MobileContentCode) >= 1
--BEGIN
--	PRINT 'Deleting Mobile Electronic Signature Text: ' + @RegistryOwnerName;
--	DELETE RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = @MobileContentCode;
--END

--IF (SELECT Count(*) FROM RegistryOwnerElectronicSignatureText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = @MobileContentCode) = 0
--BEGIN
--	PRINT 'Adding Mobile Electronic Signature Text: ' + @RegistryOwnerName;
--	INSERT RegistryOwnerElectronicSignatureText
--		(
--		RegistryOwnerID,
--		LanguageCode,
--		LblName,
--		LblAddress,		
--		LblEmail,
--		AddLblConfirmation,
--		AddCbxConfirmation,
--		AddBtnRegistration,
--		AddEmailSubject,
--		AddEmailBody,
--		AddEmailInvitationSubject,
--		AddEmailInvitationBody,
--		RemoveLblConfirmation,
--		RemoveCbxConfirmation,
--		RemoveBtnRegistration,
--		RemoveEmailSubject,
--		RemoveEmailBody,
--		EmailFrom,
--		CertificateAuthority,
--		FailureMessage,
--		LastModified,
--		LastStatEmployeeID,
--		AuditLogTypeID,
--		AddDivConfirmationNotes,
--		RemoveDivConfirmationNotes
--		)
--	VALUES
--		(
--		@RegistryOwnerID,
--		@MobileContentCode, -- LanguageCode
--		'Name:', -- LblName
--		'Address:', -- LblAddress		
--		'Email:', -- LblEmail
--		'To electronically sign your donor registration, check the "Yes" box below and click the "Complete Registration" button.', -- AddLblConfirmation
--		'Yes - I authorize donation of my organs and tissue after death in accordance with applicable state laws and subject only to the limitations noted.', -- AddCbxConfirmation
--	 	'Complete Registration', -- AddBtnRegistration
--		'Donate Life Colorado/Wyoming Organ & Tissue Donor Registry', -- AddEmailSubject
--		'Thank you for making the decision to register as an organ, eye and tissue donor through the Donate Life Colorado/Wyoming Organ & Tissue Donor Registry. This email is confirmation of your decision to donate. \r\n\r\n You will receive only one subsequent email encouraging you to share your wishes with friends and family.', -- AddEmailBody
--		'Family and Friends Invitation - Donate Life Colorado/Wyoming Organ & Tissue Donor Registry', -- AddEmailInvitationSubject
--		'Now that you''ve signed up to be an organ, eye and tissue donor through the Donate Life Colorado/Wyoming Organ & Tissue Donor Registry, please inform your friends and family and invite them to join you in giving the gift of life! Forward or copy/paste the below message and spread the word.\r\n\r\n'+
--		'I wanted to let you know that I''ve made the decision to give the gift of life by joining the Donate Life Colorado/Wyoming Organ & Tissue Donor Registry. It is a quick, easy way to register to save the lives of thousands in need of a lifesaving transplant through organ, eye and tissue donation after death. I hope you''ll take a moment to join me by learning more and registering to be an organ, eye and tissue donor at www.DonateLifeColorado.org or www.DonateLifeWyoming.org.', -- AddEmailInvitationBody
--		'To electronically sign your removal from the donor registry, check the ''Remove'' box below and click the ''Remove Registration'' button.', -- RemoveLblConfirmation
--		'Remove me from the Donate Life Colorado or Wyoming Organ & Tissue Donor Registry', -- RemoveCbxConfirmation
--		'Remove Registration', -- RemoveBtnRegistration
--		'Organ & Tissue Donor Registry Removal Confirmation', -- RemoveEmailSubject
--		'This email is confirmation of your decision to remove yourself from the Donate Life Colorado/Wyoming Organ & Tissue Donor Registry. Should you wish to join the Donate Life Colorado/Wyoming Organ and Tissue Registry again in the future, please visit www.DonateLifeColorado.org or www.DonateLifeWyoming.org.', -- RemoveEmailBody
--		'register@donoralliance.org', --EmailFrom
--		'Certificate Authority: Donor Alliance', -- CertificateAuthority
--		'Unfortunately, we have been unable to verify your registration information. Please re-submit the form and check the accuracy of your personal information including date of birth, spelling of name and address. If the issue persists, please contact us directly at <a href= "mailto:donorregistry@donoralliance.org">donorregistry@donoralliance.org<a/> or 303-329-4747 and we will assist you.', -- FailureMessage
--		GetDate(), -- LastModified
--		2778, -- LastStatEmployeeID
--		1, -- AuditLogTypeID
--		'By submitting this registration I affirm that I am the applicant described on this application and that the information entered herein is true and correct to the best of my knowledge.  This registration will serve as a document of gift as outlined in the Colorado & Wyoming Uniform Anatomical Gift Act. A document of gift, not revoked by the donor before death, is irreversible and does not require the authorization of any other person. It also authorizes any examination necessary to ensure the medical acceptability of the anatomical gift.', -- AddDivConfirmationNotes
--		'By submitting this you will be removed from the Donate Life Colorado/Wyoming Organ & Tissue Donor Registry and should receive a confirmation email shortly. If you''d like more information or wish to be added, please return to <a href="http://www.DonateLifeColorado.org"  target="_blank">www.DonateLifeColorado.org</a> or <a href="http://www.DonateLifeWyoming.org" target="_blank">www.DonateLifeWyoming.org</a>.' -- RemoveDivConfirmationNotes
--		)
--END

