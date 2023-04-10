 IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'VT' AND RegistryOwnerStateActive = 0) = 1
BEGIN
UPDATE RegistryOwnerStateConfig
	SET RegistryOwnerStateActive = 1, LastModified = GetDate()
	WHERE RegistryOwnerStateAbbrv = 'VT'
	AND RegistryOwnerStateActive = 0
END /*** NEOB SET VT Active ***/