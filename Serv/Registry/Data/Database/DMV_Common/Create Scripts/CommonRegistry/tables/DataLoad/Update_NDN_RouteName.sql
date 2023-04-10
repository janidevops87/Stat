/* Update (NDN)RegistryOwnerRouteName
	FileName: Update_NDN_RouteName.sql 
	 -------------------------------
	ccarroll - 01/13/2011 - Update NDN RegistryOwnerRouteName to 'nv' New field
	ccarroll - 01/26/2011 - Correct Nevada Donor Network phone number. Was: (720)796-9600
*/

/*** Nevada Donor Network (NDN) - Update  RegistryOwnerRouteName ***/
IF (SELECT Count(*) FROM RegistryOwner WHERE RegistryOwnerName = 'NDN' AND RegistryOwnerRouteName = 'nv') = 0
BEGIN 
	UPDATE RegistryOwner SET RegistryOwnerRouteName = 'nv' WHERE RegistryOwnerName = 'NDN'

END

/*** Correct Nevada Donor Network phone number. Was: (720)796-9600 ***/
DECLARE @RegistryOwnerID Int
SET @RegistryOwnerID = (SELECT TOP 1 RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN')

IF (SELECT Count(*) FROM RegistryOwnerEnrollmentText WHERE RegistryOwnerID = @RegistryOwnerID AND DivInformationContacts LIKE '%(720)796-9600%') > 0
BEGIN
PRINT 'Updating NDN phone Number to: (702)796-9600'
	UPDATE RegistryOwnerEnrollmentText SET DivInformationContacts = REPLACE(DivInformationContacts, '(720)796-9600', '(702)796-9600') WHERE RegistryOwnerID = @RegistryOwnerID AND DivInformationContacts LIKE '%(720)796-9600%'
END

/*** End Updates ***/
GO