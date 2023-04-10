/* Add RegistryOwnerEnrollmentText
	ccarroll 02/05/2010 - Added Nevada Donor registry (NDN)
	ccarroll 12/30/2010 - Added Nebraska (NORS)
*/

--USE DMV_Common
--GO

DECLARE @RegistryOwnerID int

/*** NDN ***/
/** Add RegistryOwnerEnrollmentText (en) language **/
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 
IF (SELECT Count(*) FROM RegistryOwnerEnrollmentText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = 'en') = 0
BEGIN

	INSERT RegistryOwnerEnrollmentText
		(
		RegistryOwnerID,
		LanguageCode,
		HeaderImageURL,
		HeaderImageWidth,
		HeaderImageHeight,
		DivInstruction,
		DivRegistrationSelection,
		LblSelectOne,
		RdoAdd,
		RdoRemove,
		DivNameInstruction,
		LblFirstName,
		LblLastName,
		LblMiddleName,
		LblGender,
		RdoMale,
		RdoFemale,
		LblDateOfBirth,
		DivResidentialAddress,
		LblStreetAddress,
		LblAddress2,
		LblCityStateZip,			
		DivContactInformation,
		LblEmailAddress,
		DivEmailConfirmation,
		DivSSN,
		LblLastFourSSN,
		DivLimitations,
		DivLimitationsInstructions,
		LblEventCategoryMessage,
		LblComment,
		DivInformationContacts,
		DivSubmitInstruction,
		BtnRegisterNow,
		ConfirmationPanelAdd,
		ConfirmationPanelRemove,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
		)
	VALUES
		(
		@RegistryOwnerID,
		'en', -- LanguageCode
		'~/Register/Dynamic/images/ndn_form_header.jpg', -- HeaderImageURL
		'299', -- HeaderImageWidth
		'95', -- HeaderImageHeight
		'Please fill out the form below to register as an organ and tissue donor. By registering ' +
        'as a donor you consent to donate your organs and tissues at the time of your death. ' +
        'Organs and tissues will be recovered for the purpose of transplantation, however, ' +
        'in the event a donated organ or tissue cannot be used for transplant, an effort ' +
        'will be made to use the donation for research.', -- DivInstruction
		'<strong>Registration Section: </strong>', -- DivRegistrationSelection
		'*Select One:', -- LblSelectOne
		'Add Myself to the Registry /Update My Record', -- RdoAdd
		'Remove Myself from the Registry', -- RdoRemoveText
		'<strong>Your Full Name</strong> (Enter legal name as it might appear on your government issued ID):', -- DivNameInstruction
		'*First Name:', -- LblFirstName
		'*Last Name:', -- LblLastName
		'Middle Name:', -- LblMiddleName
		'*Gender', -- LblGender
		'Male', -- RdoMale
		'Female', -- RdoFemale
		'*Date of Birth:', -- LblDateOfBirth
		'<strong>Residential Address </strong>', -- DivResidentialAddress
		'*Street Address:', -- LblStreetAddress
		'Address 2:', -- LblAddress2
		'*City, State, Zip:', -- LblCityStateZip			
		'<strong>Contact Information: </strong>', -- DivContactInformation
		'*Email Address:', -- LblEmailAddress
		'(for confirmation of your donor registration)', -- DivEmailConfirmation
		'<strong>Last four digits of your Social Security Number </strong>(for ID verification purposes only):', -- DivSSN
		'*Last four SS#:', -- LblLastFourSSN
		'<strong>Limitations: </strong>', -- DivLimitations
		'If there are specific organs and tissues you do NOT wish to donate, list them here. ' +
        'Also, indicate here if you do not wish your donation to be used for research.', -- DivLimitationsInstructions
		'How did you hear about the Nevada Donor Registry?', -- LblEventCategoryMessage
		'Registering in memory of:', -- LblComment
		'<strong>Information Contacts:</strong>' +
		'<table>' +
		'<tr><td width="300px;">Nevada Organ and Tissue Donor Task Force</td><td>Nevada Donor Network</td></tr>' +
		'<tr><td>(775)784-6171</td><td>(720)796-9600</td></tr>' +
		'<tr><td width="300px;">California Transplant Donor Network</td><td>Intermountain Donor Services</td></tr>' +
		'<tr><td>888-570-9400</td><td>801-521-1755</td></tr>' +
		'<tr><td width="300px;">Sierra Eye Tissue Donor Services</td><td></td></tr>' +
		'<tr><td>775-323-1566</td><td></td></tr>' +
		'</table>', -- DivInformationContacts
		'<strong>Please click on the "Submit Information" button below to continue with the registration process.</strong>', -- DivSubmitInstruction
		'Submit Information', -- BtnRegisterNow
		'Thank you for making the decision to register as an organ and/or tissue donor. You ' +
		'should receive a confirmation email shortly.' +
		'<p>' +
        'Should you wish to change your Nevada Donor Registry status at ' +
        'any time in the future, please visit <a href="http://www.nvdonor.org/"> ' +
        'www.nvdonor.org</a>' +
		'</p><p>' +
		'Please remember that Nevada Donor Registry is an independent registry. Adding ' +
        'or removing yourself from this registry does not change your donor designation status ' +
        'with your state department of motor vehicles.' +
		'</p>' +
		'Return to <a href="http://www.nvdonor.org/">www.nvdonor.org</a> ' +
		'to learn more about donation and how you can help spread the word about donation!', -- ConformationPanelAdd
		'<p>' +
        'You have been removed from the Nevada Donor Registry. You should receive a confirmation email shortly.' +
		'</p><p>' +
        'Please remember that Nevada Donor Registry is an independent registry. Adding or removing yourself from this registry ' +
		'does not change your donor designation status with your state department of motor vehicles.' +
		'</p><p>' +
        'Return to <a href="http://www.nvdonor.org/">www.nvdonor.org</a>' +
		'</p>', -- ConformationPanelRemove
		GetDate(), -- LastModified
		1100, -- LastStatEmployeeID
		1 -- AuditLogTypeID
		)
END

/** Add RegistryOwnerEnrollmentText (es) language **/
IF (SELECT Count(*) FROM RegistryOwnerEnrollmentText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = 'es') = 0
BEGIN

	INSERT RegistryOwnerEnrollmentText
		(
		RegistryOwnerID,
		LanguageCode,
		HeaderImageURL,
		HeaderImageWidth,
		HeaderImageHeight,
		DivInstruction,
		DivRegistrationSelection,
		LblSelectOne,
		RdoAdd,
		RdoRemove,
		DivNameInstruction,
		LblFirstName,
		LblLastName,
		LblMiddleName,
		LblGender,
		RdoMale,
		RdoFemale,
		LblDateOfBirth,
		DivResidentialAddress,
		LblStreetAddress,
		LblAddress2,
		LblCityStateZip,			
		DivContactInformation,
		LblEmailAddress,
		DivEmailConfirmation,
		DivSSN,
		LblLastFourSSN,
		DivLimitations,
		DivLimitationsInstructions,
		LblEventCategoryMessage,
		LblComment,
		DivInformationContacts,
		DivSubmitInstruction,
		BtnRegisterNow,
		ConfirmationPanelAdd,
		ConfirmationPanelRemove,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
		)
	VALUES
		(
		@RegistryOwnerID,
		'es', -- LanguageCode
		'~/Register/Dynamic/images/ndn_form_header.jpg', -- HeaderImageURL
		'299', -- HeaderImageWidth
		'95', -- HeaderImageHeight
		'Por favor, llene el siguiente formulario para inscribirse como donante de �rganos y tejidos. ' +
		'Registr�ndose como un donante usted da su consentimiento para donar sus �rganos y tejidos en el momento ' +
		'de su muerte. Los �rganos y tejidos ser�n recuperados para fines de trasplante, sin embargo, en el caso ' +
		'de que los �rganos o tejidos donados no puedan ser utilizados para trasplante, se har� el esfuerzo para utilizar '+
		'la donaci�n para estudios de investigaci�n.', -- DivInstruction
		'<strong>Selecci�n de Registraci�n: </strong>', -- DivRegistrationSelection
		'*Seleccione uno:', -- LblSelectOne
		'A�adirme en el registro/Actualizar mi registro', -- RdoAdd
		'Excluirme del Registro', -- RdoRemoveText
		'<strong>Su Nombre Completo</strong> (Escriba su nombre legal, como aparece en su identificaci�n emitida por el gobierno):', -- DivNameInstruction
		'*Primer Nombre:', -- LblFirstName
		'*Apellido:', -- LblLastName
		'Segundo Nombre:', -- LblMiddleName
		'*Genero', -- LblGender
		'Masculino', -- RdoMale
		'Femenino', -- RdoFemale
		'*Fecha de Nacimiento:', -- LblDateOfBirth
		'<strong>Direcci�n Residencial</strong>', -- DivResidentialAddress
		'*Direcci�n:', -- LblStreetAddress
		'Direcci�n 2:', -- LblAddress2
		'*Ciudad, Estado, C�digo Postal:', -- LblCityStateZip			
		'<strong>Informaci�n de Contacto: </strong>', -- DivContactInformation
		'*Direcci�n del Correo Electr�nico:', -- LblEmailAddress
		'(Para confirmaci�n de su registro de donante)', -- DivEmailConfirmation
		'<strong>�ltimos cuatro d�gitos de su seguro social </strong>(Solo para verificaci�n de identificaci�n):', -- DivSSN
		'*�ltimos cuatro SS#:', -- LblLastFourSSN
		'<strong>Limitaciones: </strong>', -- DivLimitations
		'Si hay �rganos y tejidos que NO desea donar, enl�stelos aqu�. Tambi�n indique aqu� si no desea ' +
		'que su donaci�n sea usada para investigaci�n', -- DivLimitationsInstructions
		'Como escuch� a cerca del Registro de Nevada Donor Registry?', -- LblEventCategoryMessage
		'Registr�ndome en memoria de:', -- LblComment
		'<strong>Informaci�n de Contacto:</strong>' +
		'<table>' +
		'<tr><td width="300px;">Nevada Organ and Tissue Donor Task Force</td><td>Nevada Donor Network</td></tr>' +
		'<tr><td>(775)784-6171</td><td>(720)796-9600</td></tr>' +
		'<tr><td width="300px;">California Transplant Donor Network</td><td>Intermountain Donor Services</td></tr>' +
		'<tr><td>888-570-9400</td><td>801-521-1755</td></tr>' +
		'<tr><td width="300px;">Sierra Eye Tissue Donor Services</td><td></td></tr>' +
		'<tr><td>775-323-1566</td><td></td></tr>' +
		'</table>', -- DivInformationContacts
		'<strong>Por favor hacer clic en �Enviar informaci�n� el bot�n de abajo para continuar con el proceso de registraci�n.</strong>', -- DivSubmitInstruction
		'Enviar informaci�n', -- BtnRegisterNow
		'Gracias por tomar la decisi�n de registrarse como donante de �rganos y tejidos. Usted deber� recibir una ' +
		'confirmaci�n en breve. Si desea cambiar su estatus del Registro de Nevada Donor en cualquier momento en el ' +
		'futuro, por favor visite <a href="http://www.nvdonor.org/">www.nvdonor.org</a>' +
		'</p><p>' +
		'Por favor recuerde que el Registro de Nevada Donor es un registro independiente. A�adiendo o ' +
		'removiendose usted mismo de este registro no cambia su estatus de donante con el departamento de estado o ' +
		'de motores y vehiculos de ninguna forma.' +
		'</p>' +
		'Regrese a <a href="http://www.nvdonor.org/">www.nvdonor.org</a> ' +
		'para aprender como puede ayudar a promover a cerca de la donacion.', -- ConformationPanelAdd
        'Usted ha sido removido del registro de donantes de Nevada. Usted deber� recibir su confirmaci�n en breve. ' +
        'Por favor recuerde que el Registro de Nevada Donor es un registro independiente. A�adiendo o ' +
		'removiendose usted mismo de este registro no cambia su estatus de donante con el departamento de estado o ' +
		'de motores y vehiculos.' +
		'<p>' +
        'Regrese a <a href="http://www.nvdonor.org/">www.nvdonor.org</a>' +
		'</p>', -- ConformationPanelRemove
		GetDate(), -- LastModified
		1100, -- LastStatEmployeeID
		1 -- AuditLogTypeID
		)
END

/*** NORS ***/
/** Add RegistryOwnerEnrollmentText (en) language **/
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerEnrollmentText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = 'en') = 0
BEGIN

	INSERT RegistryOwnerEnrollmentText
		(
		RegistryOwnerID,
		LanguageCode,
		HeaderImageURL,
		HeaderImageWidth,
		HeaderImageHeight,
		DivInstruction,
		DivRegistrationSelection,
		LblSelectOne,
		RdoAdd,
		RdoRemove,
		DivNameInstruction,
		LblFirstName,
		LblLastName,
		LblMiddleName,
		LblGender,
		RdoMale,
		RdoFemale,
		LblDateOfBirth,
		DivResidentialAddress,
		LblStreetAddress,
		LblAddress2,
		LblCityStateZip,			
		DivContactInformation,
		LblEmailAddress,
		DivEmailConfirmation,
		DivSSN,
		LblLastFourSSN,
		DivLimitations,
		DivLimitationsInstructions,
		LblEventCategoryMessage,
		LblComment,
		DivInformationContacts,
		DivSubmitInstruction,
		BtnRegisterNow,
		ConfirmationPanelAdd,
		ConfirmationPanelRemove,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
		)
	VALUES
		(
		@RegistryOwnerID,
		'en', -- LanguageCode
		'~/Register/Dynamic/images/nors_form_header.png', -- HeaderImageURL
		'600', -- HeaderImageWidth
		'190', -- HeaderImageHeight
		'<a href="/Register/ne/es">espa&#241;ol</a>' +
		'<h1>Join the Registry</h1>' +
        '<p>Thank you for registering on the Donor Registry of Nebraska, maintained by Nebraska Organ Recovery System, the federally designated organ procurement organization for Nebraska and Pottawattamie County, Iowa.  </p>' +
        '<p>Please read the following information carefully and then complete the requested information to join the registry. If you have any questions or would prefer to receive an enrollment form by mail, please contact us at 402-733-1800 or 1-877-633-1800.</p>' +
        '<h3>Donor Registry of Nebraska Statement of Anatomical Gift</h3>' +
        '<p>It is my desire to be included on the Donor Registry of Nebraska.  Upon my death, I authorize Nebraska Organ Recovery System and its authorized representatives (collectively ''NORS'') to remove all recoverable organs, eyes and tissues from my body for the purposes of transplantation, therapy, research or education unless restricted by me below.  Useable organs/eyes/tissues include: heart, lungs, liver, kidneys, pancreas, small intestine, eye tissue, heart for valves, pericardium, and bones and tissues of the upper and lower body.  Bones and tissues of the upper body include the humerus, radius, and ulna.  Bones and tissues of the lower body include the peroneous longus, patella and achilles tendons with the calcaneous and talus, anterior and posterior tibialis, fascia lata, femoral vein/artery, femur, fibula, gracilis, hemi-pelvis, meniscus, patella, saphenous vein, semitendinosis, and tibia.</p>' +
        '<p>I authorize NORS to obtain my complete medical record and autopsy report.  I authorize all tests and other examinations, including but not limited to infectious disease testing, to determine the medical suitability of my anatomical gift.  I authorize NORS to disclose all information, as necessary, to individuals and entities who receive or use my anatomical gift.</p>' +
        '<p>I understand that my estate, next of kin or other survivors shall be responsible for all of my hospital, medical and funeral expenses and that NORS shall be responsible for all costs and expenses incurred after my death that are directly related to the recovery of my anatomical gift.</p>' +
        '<p>I understand that making this statement electronically has the same effect as signing a written statement.</p>' +
        '<p>I am at least sixteen (16) years old.</p>', -- DivInstruction
		'<h2><span style=''color:green;''>Donor Information</span></h2><div>Fields marked with a <span style=''color:red;''>*</span> are required.</div>', -- DivRegistrationSelection
		'<span style=''color:red;''>* </span>Please select one of the following:', -- LblSelectOne
		'Yes, I want to join the Donor Registry.', -- RdoAdd
		'Please take me out of the Donor Registry.', -- RdoRemoveText
		'', -- DivNameInstruction
		'<span style=''color:red;''>* </span>First Name:', -- LblFirstName
		'<span style=''color:red;''>* </span>Last Name:', -- LblLastName
		'Middle Name:', -- LblMiddleName
		'<span style=''color:red;''>* </span>Gender', -- LblGender
		'Male', -- RdoMale
		'Female', -- RdoFemale
		'<span style=''color:red;''>* </span>Date of Birth:', -- LblDateOfBirth
		'<h2><span style=''color:green;''>Residential Address</span></h2>', -- DivResidentialAddress
		'<span style=''color:red;''>* </span>Street Address:', -- LblStreetAddress
		'Address 2:', -- LblAddress2
		'<span style=''color:red;''>* </span>City, State, Zip:', -- LblCityStateZip			
		'<h2><span style=''color:green;''>Contact Information</span></h2>', -- DivContactInformation
		'<span style=''color:red;''>* </span>Email Address:', -- LblEmailAddress
		'(for confirmation of your donor registration)', -- DivEmailConfirmation
		'<strong>Last four digits of your Social Security Number </strong>(for ID verification purposes only):', -- DivSSN
		'<span style=''color:red;''>* </span>Last four SS#:', -- LblLastFourSSN
		'<h2><span style=''color:green;''>Donor Restrictions</span></h2>', -- DivLimitations
		'The Registry will only accommodate restrictions related to individual organs or tissues that can be removed for purposes of transplantation. Organs are distributed according to national regulations.<p>Anatomical Gift Restrictions (no narrative):</p>', -- DivLimitationsInstructions
		'<h2><span style=''color:green;''>Other Information</span></h2><span style=''color:red;''>* </span>How did you hear about us?', -- LblEventCategoryMessage
		'Other Information:', -- LblComment
		'NORS recommends that you communicate your decision to make an anatomical gift to your family and loved ones, as your presence in the Donor Registry of Nebraska will serve as legal consent for donation. NORS'' representatives will attempt to contact your family at the time of your death to notify them of your decision to make an anatomical gift and to request information about your social and medical history.', -- DivInformationContacts
		'<strong>Please click on the "Register now" button below to continue with the registration process.</strong>', -- DivSubmitInstruction
		'Register Now', -- BtnRegisterNow
		'<p>Thank you for registering on the Donor Registry of Nebraska. The Donor Registry of Nebraska is maintained by Nebraska Organ Recovery System, the federally designated organ procurement organization for Nebraska and Pottawattamie County, Iowa. You have authorized Nebraska Organ Recovery System and its authorized representatives (collectively �NORS�) to remove all recoverable organs, eyes and tissues from your body upon your death. Your donation may be used for transplantation, therapy, research or education except as restricted below by you.</p><p>You have authorized NORS to obtain your complete medical record and autopsy report. You have authorized all tests and other examinations, including but not limited to infectious disease testing, to determine the medical suitability of your anatomical gift. You have authorized NORS to disclose all information, as necessary, to individuals and entities who receive or use your anatomical gift.</p><p>Your estate, next of kin or other survivors shall be responsible for all of your hospital, medical and funeral expenses. NORS shall be responsible for all costs and expenses incurred after your death that are directly related to the recovery of your anatomical gift.</p><p> NORS recommends that you communicate your decision to make an anatomical gift to your family and loved ones. NORS'' representatives will attempt to contact your family at the time of your death to notify them of your decision to make an anatomical gift and to request information about your social and medical history.</p>', -- ConformationPanelAdd
		'<p>' +
        'You have been removed from the Donor Registry of Nebraska. You should receive a confirmation email shortly.' +
		'</p><p>' +
        'Please remember that Donor Registry of Nebraska is an independent registry. Adding or removing yourself from this registry ' +
		'does not change your donor designation status with your state department of motor vehicles.' +
		'</p><p>' +
        'Return to <a href="http://www.nedonation.org/">www.nedonation.org</a>' +
		'</p>', -- ConformationPanelRemove
		GetDate(), -- LastModified
		1100, -- LastStatEmployeeID
		1 -- AuditLogTypeID
		)
END

/** Add NORS RegistryOwnerEnrollmentText (es) language **/
IF (SELECT Count(*) FROM RegistryOwnerEnrollmentText WHERE RegistryOwnerID = @RegistryOwnerID AND LanguageCode = 'es') = 0
BEGIN

	INSERT RegistryOwnerEnrollmentText
		(
		RegistryOwnerID,
		LanguageCode,
		HeaderImageURL,
		HeaderImageWidth,
		HeaderImageHeight,
		DivInstruction,
		DivRegistrationSelection,
		LblSelectOne,
		RdoAdd,
		RdoRemove,
		DivNameInstruction,
		LblFirstName,
		LblLastName,
		LblMiddleName,
		LblGender,
		RdoMale,
		RdoFemale,
		LblDateOfBirth,
		DivResidentialAddress,
		LblStreetAddress,
		LblAddress2,
		LblCityStateZip,			
		DivContactInformation,
		LblEmailAddress,
		DivEmailConfirmation,
		DivSSN,
		LblLastFourSSN,
		DivLimitations,
		DivLimitationsInstructions,
		LblEventCategoryMessage,
		LblComment,
		DivInformationContacts,
		DivSubmitInstruction,
		BtnRegisterNow,
		ConfirmationPanelAdd,
		ConfirmationPanelRemove,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
		)
	VALUES
		(
		@RegistryOwnerID,
		'es', -- LanguageCode
		'~/Register/Dynamic/images/nors_form_header.png', -- HeaderImageURL
		'600', -- HeaderImageWidth
		'190', -- HeaderImageHeight
		'<a href="/Register/ne/en">english</a>' +
		'<h1>�nete a la Secretar�a</h1>' +
		'<p>Gracias por registrarse en el Registro de Donantes de Nebraska, gestionada por �rganos de Nebraska La recuperaci�n del sistema, la organizaci�n de obtenci�n de �rganos federales designados para Nebraska y Condado Pottawattamie, Iowa.</p>' +
		'<p>Por favor, lea atentamente la siguiente informaci�n y luego completar la informaci�n solicitada a unirse el registro. Si tiene cualquier pregunta o prefiere recibir un formulario de inscripci�n por correo, por favor en contacto con nosotros en el 402-733-1800 o 1-877-633-1800.' +
		'<h3>Registro de Donantes de la Declaraci�n de Nebraska de donaci�n de �rganos</h3>' +
		'<p>Es mi deseo de ser incluido en el Registro de Donantes de Nebraska. Despu�s de mi muerte, yo autorizo a Nebraska, Sistema de Recuperaci�n de �rganos y sus representantes autorizados (en adelante "NORS") para eliminar todos los �rganos de reembolso ojos y los tejidos de mi cuerpo a los efectos del trasplante, el tratamiento, la investigaci�n o la educaci�n a menos restringido por debajo de m�. -capaz de utilizar los �rganos / ojos / tejidos incluyen: coraz�n, pulmones, h�gado, ri�ones, p�ncreas, tejido del intestino delgado, ojos, coraz�n para v�lvulas, el pericardio, y los huesos y los tejidos del cuerpo superior e inferior. Los huesos y los tejidos de la parte superior del cuerpo incluyen el h�mero, el radio y c�bito. Los huesos y los tejidos de la parte inferior del cuerpo incluyen la r�tula y el tend�n de la r�tula, el tend�n de Aquiles con el calc�neo yel astr�galo, los tendons de tibial anterior y posterior, la fascia lata, f�mur, peron�, gracilis, hemi-pelvis, meniscos, vena safena, semitendinosis, y la tibia.</p>' +
		'<p>Yo autorizo NORS para obtener mi historial m�dico completo y el informe de la autopsia. Yo autorizo a todas las pruebas y otros ex�menes, incluyendo pero no limitado a pruebas de enfermedades infecciosas, para determinar la conveniencia m�dica de mi regalo anat�mico. Yo autorizo NORS a revelar toda la informaci�n, seg�n sea necesario, a las personas y entidades que reciben o utilizar mi regalo anat�mico.</p>'+
		'<p>Entiendo que mi patrimonio, a los familiares o sobrevivientes de otros ser� responsable de todos mis gastos de hospital, m�dicos y funerarios, y que NORS ser� responsable de todos los costos y gastos incurridos despu�s de mi muerte, que est�n directamente relacionados con la recuperaci�n de mi anatom�a regalo.</p>'+
		'<p>Entiendo que hacer esta declaraci�n por v�a electr�nica tiene el mismo efecto que la firma de la declaraci�n por escrito.</p>'+
		'<p>Tengo por lo menos diecis�is (16) a�os de edad.</p>', -- DivInstruction'
		'<h2><span style=''color:green;''>Informaci�n del donante</span></h2><div>Los campos marcados con un <span style=''color:red;''>*</span>se requieren.</div>', -- DivRegistrationSelection
		'<span style=''color:red;''>* </span>Por favor, seleccione una de las siguientes:', -- LblSelectOne
		'S�, quiero inscribirse en el Registro de Donantes.', -- RdoAdd
		'Por favor, s�came del Registro de Donantes.', -- RdoRemoveText
		'', -- DivNameInstruction
		'<span style=''color:red;''>* </span>Primer Nombre:', -- LblFirstName
		'<span style=''color:red;''>* </span>Apellido:', -- LblLastName
		'Segundo Nombre:', -- LblMiddleName
		'<span style=''color:red;''>* </span>G�nero', -- LblGender
		'Masculino', -- RdoMale
		'Femenino', -- RdoFemale
		'<span style=''color:red;''>* </span>Fecha de Nacimiento:', -- LblDateOfBirth
		'<h2><span style=''color:green;''>Direcci�n Residencial</span></h2>', -- DivResidentialAddress
		'<span style=''color:red;''>* </span>Direcci�n:', -- LblStreetAddress
		'Direcci�n 2:', -- LblAddress2
		'<span style=''color:red;''>* </span>Ciudad, Estado, C�digo Postal:', -- LblCityStateZip			
		'<h2><span style=''color:green;''>informaci�n de Contacto</span></h2>', -- DivContactInformation
		'<span style=''color:red;''>* </span>Direcci�n del Correo Electr�nico:', -- LblEmailAddress
		'(Para confirmaci�n de su registro de donante)', -- DivEmailConfirmation
		'<strong>�ltimos cuatro d�gitos de su seguro social </strong>(Solo para verificaci�n de identificaci�n):', -- DivSSN
		'<span style=''color:red;''>* </span>�ltimos cuatro SS#:', -- LblLastFourSSN
		'<h2><span style=''color:green;''>Restricciones de los donantes</span></h2>', -- DivLimitations
		'Si hay �rganos y tejidos que NO desea donar, enl�stelos aqu�. Tambi�n indique aqu� si no desea ' +
		'El Registro s�lo tendr� en cuenta las restricciones relacionadas con los distintos �rganos o tejidos que se pueden quitar con fines de trasplante. Los �rganos se distribuyen de acuerdo a las normativas nacionales.<p>Anatomical Gift Restricciones (no narrativa):</p>', -- DivLimitationsInstructions
		'<h2><span style=''color:green;''>Otra informaci�n</span></h2><span style=''color:red;''>* </span>�C�mo se enter� de nosotros?', -- LblEventCategoryMessage
		'Registr�ndome en memoria de:', -- LblComment
		'NORS recomienda que se comunique su decisi�n de hacer un regalo anat�mico para su familia y seres queridos, como su presencia en el Registro de Donantes de Nebraska servir� de consentimiento legal para la donaci�n. NORS representantes intentar� comunicarse con su familia en el momento de su muerte para notificarles de su decisi�n de hacer un regalo anat�mico y para solicitar informaci�n acerca de la historia social y m�dica.', -- DivInformationContacts
		'<strong>Por favor, haga clic en "Reg�strese ahora" bot�n de abajo para continuar con el proceso de registro.</strong>', -- DivSubmitInstruction
		'Reg�strese ahora', -- BtnRegisterNow
		'<p>Gracias par registrarse en el Registro de Donantes de Nebraska. El Registro de Donantes de Nebraska es gestionada por Nebraska, Sistema de Recuperaci�n de �rganos, la organizaci�n de obtenci�n de �rganos federales designados para Nebraska y Pottawattamie County, Iowa. Se han autorizado Nebraska Sistema de Recuperaci�n de �rganos y sus representantes autorizados (en adelante "NORS") para eliminar todos los �rganos de reembolso ojos y los tejidos de su cuerpo despu�s de su muerte. Su donaci�n puede ser utilizado para el trasplante, el tratamiento, investigaci�n o educaci�n, salvo como restringido a continuaci�n por usted.</p><p>Se han autorizado NORS para obtener su registro m�dico completo y informe de la autopsia. Se han autorizado todas las pruebas y otros ex�menes, incluyendo pero no limitado a pruebas de enfermedades infecciosas, para determinar la conveniencia m�dica de su regalo anat�mico. Se han autorizado NORS a revelar toda la informaci�n, seg�n sea necesario, a las personas y entidades que reciben o el uso de su regalo anat�mico.</p><p>Su patrimonio, a los familiares o sobrevivientes de otros ser� responsable de todos sus gastos de hospital, m�dicos y funerarios. NORS ser� responsable de todos los costos y gastos incurridos despu�s de su muerte que est�n directamente relacionados con la recuperaci�n de la donaci�n de �rganos.</p><p>NORS recomienda que se comunique su decisi�n de hacer un regalo anat�mico para su familia y seres queridos. NORS''representantes intentar� comunicarse con su familia en el momento de su muerte para notificarles de su decisi�n de hacer un regalo anat�mico y para solicitar informaci�n acerca de la historia social y m�dica.</p>', -- ConformationPanelAdd
        '<p>Usted ha sido eliminado del Registro de Donantes de Nebraska. Usted debe recibir un email de confirmaci�n en breve.</p><p>Por favor recuerde que Registro de Donantes de Nebraska es un registro independiente. Agregar o darse de baja de este registro no modifica el estado de su designaci�n de donante con el departamento de estado de los veh�culos de motor</p><p>Volver a <a href="http://www.nedonation.org/">www.nedonation.org</a></p>', -- ConfirmationPanelRemove
		GetDate(), -- LastModified
		1100, -- LastStatEmployeeID
		1 -- AuditLogTypeID
		)
END

GO


