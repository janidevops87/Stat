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
		'Por favor, llene el siguiente formulario para inscribirse como donante de órganos y tejidos. ' +
		'Registrándose como un donante usted da su consentimiento para donar sus órganos y tejidos en el momento ' +
		'de su muerte. Los órganos y tejidos serán recuperados para fines de trasplante, sin embargo, en el caso ' +
		'de que los órganos o tejidos donados no puedan ser utilizados para trasplante, se hará el esfuerzo para utilizar '+
		'la donación para estudios de investigación.', -- DivInstruction
		'<strong>Selección de Registración: </strong>', -- DivRegistrationSelection
		'*Seleccione uno:', -- LblSelectOne
		'Añadirme en el registro/Actualizar mi registro', -- RdoAdd
		'Excluirme del Registro', -- RdoRemoveText
		'<strong>Su Nombre Completo</strong> (Escriba su nombre legal, como aparece en su identificación emitida por el gobierno):', -- DivNameInstruction
		'*Primer Nombre:', -- LblFirstName
		'*Apellido:', -- LblLastName
		'Segundo Nombre:', -- LblMiddleName
		'*Genero', -- LblGender
		'Masculino', -- RdoMale
		'Femenino', -- RdoFemale
		'*Fecha de Nacimiento:', -- LblDateOfBirth
		'<strong>Dirección Residencial</strong>', -- DivResidentialAddress
		'*Dirección:', -- LblStreetAddress
		'Dirección 2:', -- LblAddress2
		'*Ciudad, Estado, Código Postal:', -- LblCityStateZip			
		'<strong>Información de Contacto: </strong>', -- DivContactInformation
		'*Dirección del Correo Electrónico:', -- LblEmailAddress
		'(Para confirmación de su registro de donante)', -- DivEmailConfirmation
		'<strong>Últimos cuatro dígitos de su seguro social </strong>(Solo para verificación de identificación):', -- DivSSN
		'*Últimos cuatro SS#:', -- LblLastFourSSN
		'<strong>Limitaciones: </strong>', -- DivLimitations
		'Si hay órganos y tejidos que NO desea donar, enlístelos aquí. También indique aquí si no desea ' +
		'que su donación sea usada para investigación', -- DivLimitationsInstructions
		'Como escuchó a cerca del Registro de Nevada Donor Registry?', -- LblEventCategoryMessage
		'Registrándome en memoria de:', -- LblComment
		'<strong>Información de Contacto:</strong>' +
		'<table>' +
		'<tr><td width="300px;">Nevada Organ and Tissue Donor Task Force</td><td>Nevada Donor Network</td></tr>' +
		'<tr><td>(775)784-6171</td><td>(720)796-9600</td></tr>' +
		'<tr><td width="300px;">California Transplant Donor Network</td><td>Intermountain Donor Services</td></tr>' +
		'<tr><td>888-570-9400</td><td>801-521-1755</td></tr>' +
		'<tr><td width="300px;">Sierra Eye Tissue Donor Services</td><td></td></tr>' +
		'<tr><td>775-323-1566</td><td></td></tr>' +
		'</table>', -- DivInformationContacts
		'<strong>Por favor hacer clic en “Enviar información” el botón de abajo para continuar con el proceso de registración.</strong>', -- DivSubmitInstruction
		'Enviar información', -- BtnRegisterNow
		'Gracias por tomar la decisión de registrarse como donante de órganos y tejidos. Usted deberá recibir una ' +
		'confirmación en breve. Si desea cambiar su estatus del Registro de Nevada Donor en cualquier momento en el ' +
		'futuro, por favor visite <a href="http://www.nvdonor.org/">www.nvdonor.org</a>' +
		'</p><p>' +
		'Por favor recuerde que el Registro de Nevada Donor es un registro independiente. Añadiendo o ' +
		'removiendose usted mismo de este registro no cambia su estatus de donante con el departamento de estado o ' +
		'de motores y vehiculos de ninguna forma.' +
		'</p>' +
		'Regrese a <a href="http://www.nvdonor.org/">www.nvdonor.org</a> ' +
		'para aprender como puede ayudar a promover a cerca de la donacion.', -- ConformationPanelAdd
        'Usted ha sido removido del registro de donantes de Nevada. Usted deberá recibir su confirmación en breve. ' +
        'Por favor recuerde que el Registro de Nevada Donor es un registro independiente. Añadiendo o ' +
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
		'<p>Thank you for registering on the Donor Registry of Nebraska. The Donor Registry of Nebraska is maintained by Nebraska Organ Recovery System, the federally designated organ procurement organization for Nebraska and Pottawattamie County, Iowa. You have authorized Nebraska Organ Recovery System and its authorized representatives (collectively “NORS”) to remove all recoverable organs, eyes and tissues from your body upon your death. Your donation may be used for transplantation, therapy, research or education except as restricted below by you.</p><p>You have authorized NORS to obtain your complete medical record and autopsy report. You have authorized all tests and other examinations, including but not limited to infectious disease testing, to determine the medical suitability of your anatomical gift. You have authorized NORS to disclose all information, as necessary, to individuals and entities who receive or use your anatomical gift.</p><p>Your estate, next of kin or other survivors shall be responsible for all of your hospital, medical and funeral expenses. NORS shall be responsible for all costs and expenses incurred after your death that are directly related to the recovery of your anatomical gift.</p><p> NORS recommends that you communicate your decision to make an anatomical gift to your family and loved ones. NORS'' representatives will attempt to contact your family at the time of your death to notify them of your decision to make an anatomical gift and to request information about your social and medical history.</p>', -- ConformationPanelAdd
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
		'<h1>Únete a la Secretaría</h1>' +
		'<p>Gracias por registrarse en el Registro de Donantes de Nebraska, gestionada por órganos de Nebraska La recuperación del sistema, la organización de obtención de órganos federales designados para Nebraska y Condado Pottawattamie, Iowa.</p>' +
		'<p>Por favor, lea atentamente la siguiente información y luego completar la información solicitada a unirse el registro. Si tiene cualquier pregunta o prefiere recibir un formulario de inscripción por correo, por favor en contacto con nosotros en el 402-733-1800 o 1-877-633-1800.' +
		'<h3>Registro de Donantes de la Declaración de Nebraska de donación de órganos</h3>' +
		'<p>Es mi deseo de ser incluido en el Registro de Donantes de Nebraska. Después de mi muerte, yo autorizo a Nebraska, Sistema de Recuperación de Órganos y sus representantes autorizados (en adelante "NORS") para eliminar todos los órganos de reembolso ojos y los tejidos de mi cuerpo a los efectos del trasplante, el tratamiento, la investigación o la educación a menos restringido por debajo de mí. -capaz de utilizar los órganos / ojos / tejidos incluyen: corazón, pulmones, hígado, riñones, páncreas, tejido del intestino delgado, ojos, corazón para válvulas, el pericardio, y los huesos y los tejidos del cuerpo superior e inferior. Los huesos y los tejidos de la parte superior del cuerpo incluyen el húmero, el radio y cúbito. Los huesos y los tejidos de la parte inferior del cuerpo incluyen la rótula y el tendón de la rótula, el tendón de Aquiles con el calcáneo yel astrágalo, los tendons de tibial anterior y posterior, la fascia lata, fémur, peroné, gracilis, hemi-pelvis, meniscos, vena safena, semitendinosis, y la tibia.</p>' +
		'<p>Yo autorizo NORS para obtener mi historial médico completo y el informe de la autopsia. Yo autorizo a todas las pruebas y otros exámenes, incluyendo pero no limitado a pruebas de enfermedades infecciosas, para determinar la conveniencia médica de mi regalo anatómico. Yo autorizo NORS a revelar toda la información, según sea necesario, a las personas y entidades que reciben o utilizar mi regalo anatómico.</p>'+
		'<p>Entiendo que mi patrimonio, a los familiares o sobrevivientes de otros será responsable de todos mis gastos de hospital, médicos y funerarios, y que NORS será responsable de todos los costos y gastos incurridos después de mi muerte, que están directamente relacionados con la recuperación de mi anatomía regalo.</p>'+
		'<p>Entiendo que hacer esta declaración por vía electrónica tiene el mismo efecto que la firma de la declaración por escrito.</p>'+
		'<p>Tengo por lo menos dieciséis (16) años de edad.</p>', -- DivInstruction'
		'<h2><span style=''color:green;''>Información del donante</span></h2><div>Los campos marcados con un <span style=''color:red;''>*</span>se requieren.</div>', -- DivRegistrationSelection
		'<span style=''color:red;''>* </span>Por favor, seleccione una de las siguientes:', -- LblSelectOne
		'Sí, quiero inscribirse en el Registro de Donantes.', -- RdoAdd
		'Por favor, sácame del Registro de Donantes.', -- RdoRemoveText
		'', -- DivNameInstruction
		'<span style=''color:red;''>* </span>Primer Nombre:', -- LblFirstName
		'<span style=''color:red;''>* </span>Apellido:', -- LblLastName
		'Segundo Nombre:', -- LblMiddleName
		'<span style=''color:red;''>* </span>Género', -- LblGender
		'Masculino', -- RdoMale
		'Femenino', -- RdoFemale
		'<span style=''color:red;''>* </span>Fecha de Nacimiento:', -- LblDateOfBirth
		'<h2><span style=''color:green;''>Dirección Residencial</span></h2>', -- DivResidentialAddress
		'<span style=''color:red;''>* </span>Dirección:', -- LblStreetAddress
		'Dirección 2:', -- LblAddress2
		'<span style=''color:red;''>* </span>Ciudad, Estado, Código Postal:', -- LblCityStateZip			
		'<h2><span style=''color:green;''>información de Contacto</span></h2>', -- DivContactInformation
		'<span style=''color:red;''>* </span>Dirección del Correo Electrónico:', -- LblEmailAddress
		'(Para confirmación de su registro de donante)', -- DivEmailConfirmation
		'<strong>Últimos cuatro dígitos de su seguro social </strong>(Solo para verificación de identificación):', -- DivSSN
		'<span style=''color:red;''>* </span>Últimos cuatro SS#:', -- LblLastFourSSN
		'<h2><span style=''color:green;''>Restricciones de los donantes</span></h2>', -- DivLimitations
		'Si hay órganos y tejidos que NO desea donar, enlístelos aquí. También indique aquí si no desea ' +
		'El Registro sólo tendrá en cuenta las restricciones relacionadas con los distintos órganos o tejidos que se pueden quitar con fines de trasplante. Los órganos se distribuyen de acuerdo a las normativas nacionales.<p>Anatomical Gift Restricciones (no narrativa):</p>', -- DivLimitationsInstructions
		'<h2><span style=''color:green;''>Otra información</span></h2><span style=''color:red;''>* </span>¿Cómo se enteró de nosotros?', -- LblEventCategoryMessage
		'Registrándome en memoria de:', -- LblComment
		'NORS recomienda que se comunique su decisión de hacer un regalo anatómico para su familia y seres queridos, como su presencia en el Registro de Donantes de Nebraska servirá de consentimiento legal para la donación. NORS representantes intentará comunicarse con su familia en el momento de su muerte para notificarles de su decisión de hacer un regalo anatómico y para solicitar información acerca de la historia social y médica.', -- DivInformationContacts
		'<strong>Por favor, haga clic en "Regístrese ahora" botón de abajo para continuar con el proceso de registro.</strong>', -- DivSubmitInstruction
		'Regístrese ahora', -- BtnRegisterNow
		'<p>Gracias par registrarse en el Registro de Donantes de Nebraska. El Registro de Donantes de Nebraska es gestionada por Nebraska, Sistema de Recuperación de Órganos, la organización de obtención de órganos federales designados para Nebraska y Pottawattamie County, Iowa. Se han autorizado Nebraska Sistema de Recuperación de Órganos y sus representantes autorizados (en adelante "NORS") para eliminar todos los órganos de reembolso ojos y los tejidos de su cuerpo después de su muerte. Su donación puede ser utilizado para el trasplante, el tratamiento, investigación o educación, salvo como restringido a continuación por usted.</p><p>Se han autorizado NORS para obtener su registro médico completo y informe de la autopsia. Se han autorizado todas las pruebas y otros exámenes, incluyendo pero no limitado a pruebas de enfermedades infecciosas, para determinar la conveniencia médica de su regalo anatómico. Se han autorizado NORS a revelar toda la información, según sea necesario, a las personas y entidades que reciben o el uso de su regalo anatómico.</p><p>Su patrimonio, a los familiares o sobrevivientes de otros será responsable de todos sus gastos de hospital, médicos y funerarios. NORS será responsable de todos los costos y gastos incurridos después de su muerte que están directamente relacionados con la recuperación de la donación de órganos.</p><p>NORS recomienda que se comunique su decisión de hacer un regalo anatómico para su familia y seres queridos. NORS''representantes intentará comunicarse con su familia en el momento de su muerte para notificarles de su decisión de hacer un regalo anatómico y para solicitar información acerca de la historia social y médica.</p>', -- ConformationPanelAdd
        '<p>Usted ha sido eliminado del Registro de Donantes de Nebraska. Usted debe recibir un email de confirmación en breve.</p><p>Por favor recuerde que Registro de Donantes de Nebraska es un registro independiente. Agregar o darse de baja de este registro no modifica el estado de su designación de donante con el departamento de estado de los vehículos de motor</p><p>Volver a <a href="http://www.nedonation.org/">www.nedonation.org</a></p>', -- ConfirmationPanelRemove
		GetDate(), -- LastModified
		1100, -- LastStatEmployeeID
		1 -- AuditLogTypeID
		)
END

GO


