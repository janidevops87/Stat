/**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)**/
 
DECLARE @PERSONTYPEIDCOUNT INT  =(select  COUNT(*) from Person where PersonTypeID not in (select PersonTypeID from PersonType)) 
IF (@PERSONTYPEIDCOUNT > 0)
BEGIN
	PRINT ' Update Person PersonTypeID'
	 UPDATE Person 
	 SET PersonTypeID = NULL 
	 WHERE PersonTypeID NOT IN (SELECT PersonTypeID FROM PersonType)
END

DECLARE @ORGANIZATIONIDCOUNT int = (SELECT COUNT(Person.PersonID) FROM Person WHERE OrganizationID NOT IN (SELECT OrganizationID FROM Organization))
IF (@ORGANIZATIONIDCOUNT > 0)
BEGIN
	UPDATE Person
	SET OrganizationID = NULL
	WHERE OrganizationID NOT IN (SELECT OrganizationID FROM Organization)
END

DECLARE @LASTSTATEMPLOYEEIDCOUNT INT = (SELECT COUNT(Person.PersonID) FROM Person WHERE LastStatEmployeeID NOT IN (SELECT StatEmployeeID FROM StatEmployee))
IF (@LASTSTATEMPLOYEEIDCOUNT > 0)
BEGIN
	UPDATE Person
	SET LastStatEmployeeID = NULL
	WHERE LastStatEmployeeID NOT IN (SELECT StatEmployeeID FROM StatEmployee)
END
-- SELECT * FROM Person WHERE PersonFirst = 'Christine' AND PersonLast = 'Ajer'


	UPDATE Person
	SET 
		Person.Credential = ISNULL(Person.Credential, '')
		,Person.TrainedRequestorID = CASE WHEN Person.PersonLast LIKE '%*%' THEN 1 ELSE 2 END
		--,Person.GenderID = CASE WHEN Person.GenderID IS NULL THEN 4 ELSE Person.GenderID END
		--,Person.RaceID = CASE WHEN Person.RaceID IS NULL THEN 6 ELSE Person.RaceID END
		
		
	
update Person
set PersonBusy = 0
where personbusy is null

update Person
set PersonTempNoteActive = 0
where PersonTempNoteActive is null

update Person
set PersonBusy = 1
where PersonBusy = -1

update Person
set PersonTempNoteActive = 1
where persontempnoteActive = -1