------Start Update-----------------
/* Uncomment to back-up data 
	SELECT ID, LastModified, DOB  INTO _BackupDOB_07302009
	FROM Registry
	GO 
*/

/* Test-Correct DOB anomalies CODA 
	SELECT ID, DOB AS 'Old_DOB', DateAdd(yyyy,-100, DOB) AS 'New_DOB' FROM Registry WHERE DatePart(yyyy, DOB) > '2009' 
*/

/* NOTE: Replication needs to be dropped prior to execution of the ALTER TABLE command.
		 Not doing so will result in LastModified dates being updated.
*/
ALTER TABLE Registry DISABLE TRIGGER Update_REGISTRY
GO

UPDATE Registry SET DOB = DateAdd(yyyy,-100, DOB)
WHERE DatePart(yyyy, DOB) > '2009' 
GO

ALTER TABLE Registry ENABLE TRIGGER Update_REGISTRY
GO
------End Update ------------------
