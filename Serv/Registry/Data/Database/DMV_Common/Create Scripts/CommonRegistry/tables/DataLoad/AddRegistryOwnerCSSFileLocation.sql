 /*	AddRegistryOwnerCSSFileLocation
	
	ccarroll 03/17/2011 initial release

	Filename:
	Decription: This dataload script adds the file location of the 
	CSS file use on the following dynamic pages
		1. Enrollment
		2. Signature
		3. Validation
		
		To add CSSFileLocations change the RegistryOwnerName found in the 
		RegistryOwner table
		To force an update where CSSFileLocation exists remove from WHERE:
			 AND IsNull(RegistryOwnerCSSFile, '') = ''
*/


DECLARE @RegistryOwnerID int
DECLARE @RegistryOwnerName AS nvarchar (100)
DECLARE @CSSFileLocation AS nvarchar (250)

/*** Start Update ***/
/* Nevada Donor registry (NDN)*/
SET @RegistryOwnerName = 'NDN'
SET @CSSFileLocation = '~/Framework/Themes/Default/Enrollment.css'

SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName) 
IF IsNull(@RegistryOwnerID, 0) > 0
BEGIN
	UPDATE RegistryOwner SET CSSFileLocation = @CSSFileLocation WHERE RegistryOwnerID = @RegistryOwnerID AND IsNull(CSSFileLocation, '') = ''
	PRINT 'Dataload Table: RegistryOwner ' + @RegistryOwnerName + ', Adding CSSFileLocation: ' + @CSSFileLocation
END

/* Colorado Donor Alliance (CODA)*/
SET @RegistryOwnerName = 'CODA'
SET @CSSFileLocation = '~/Framework/Themes/Default/Enrollment.css'

SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName) 
IF IsNull(@RegistryOwnerID, 0) > 0
BEGIN
	UPDATE RegistryOwner SET CSSFileLocation = @CSSFileLocation WHERE RegistryOwnerID = @RegistryOwnerID AND IsNull(CSSFileLocation, '') = ''
	PRINT 'Dataload Table: RegistryOwner ' + @RegistryOwnerName + ', Adding CSSFileLocation: ' + @CSSFileLocation
END

/* Nebraska Organ Donor Recovery Service (NORS)*/
SET @RegistryOwnerName = 'NORS'
SET @CSSFileLocation = '~/Framework/Themes/NORS/Enrollment.css'

SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName) 
IF IsNull(@RegistryOwnerID, 0) > 0
BEGIN
	UPDATE RegistryOwner SET CSSFileLocation = @CSSFileLocation WHERE RegistryOwnerID = @RegistryOwnerID AND IsNull(CSSFileLocation, '') = ''
	PRINT 'Dataload Table: RegistryOwner ' + @RegistryOwnerName + ', Adding CSSFileLocation: ' + @CSSFileLocation
END


/*** End Update ***/
GO



