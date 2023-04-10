/* ---- Test Section ------ */

/* Show un-cleaned names */
--SELECT DOB, FirstName, MiddleName, LastName
/* Preview Names after cleaning */
--SELECT TOP 1000 DOB, dbo.REMOVE_BAD255(FirstName), dbo.REMOVE_BAD255(MiddleName), dbo.REMOVE_BAD255(LastName)
--FROM Registry
--WHERE PATINDEX('%[^a-z^A-Z]%',FirstName) > 0
--OR PATINDEX('%[^a-z^A-Z]%',MiddleName) > 0
--OR PATINDEX('%[^a-z^A-Z]%',LastName) > 0

/* Create backup */ 
SELECT * INTO _RegistryBackup FROM Registry

/* Test Backup */
--SELECT TOP 1000 * FROM _RegistryBackup 
--WHERE PATINDEX('%[^a-z^A-Z]%',FirstName) > 0
--OR PATINDEX('%[^a-z^A-Z]%',MiddleName) > 0
--OR PATINDEX('%[^a-z^A-Z]%',LastName) > 0
/* End Test Section */

/***** Update Registry *****/
UPDATE Registry 
	SET LastName = dbo.REMOVE_BAD255(LastName)
WHERE PATINDEX('%[^a-z^A-Z]%',LastName) > 0
GO

UPDATE Registry 
	SET MiddleName = dbo.REMOVE_BAD255(MiddleName)
WHERE PATINDEX('%[^a-z^A-Z]%',MiddleName) > 0
GO

UPDATE Registry 
	SET FirstName = dbo.REMOVE_BAD255(FirstName)
WHERE PATINDEX('%[^a-z^A-Z]%',FirstName) > 0
GO
/***** End Update *****/
