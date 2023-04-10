------Update Start-----------------
-- for Release 01/05/2009
/* Correct LastModified dates from previous update */
ALTER TABLE Registry DISABLE TRIGGER Update_REGISTRY
GO

/* Uncomment to back-up data 
SELECT ID, LastModified, DOB  INTO _BackupRegistry12162008
FROM Registry
GO 

SELECT *  INTO _BackupEventRegistry01052009
FROM EventRegistry
GO 
*/

UPDATE Registry 
SET registry.LastModified = RegistryAddr.LastModified
FROM Registry 
JOIN RegistryADDR ON Registry.ID = RegistryAddr.RegistryID AND RegistryAddr.AddrTypeID = 1
WHERE convert(varchar, Registry.LastModified, 101) = '10/15/2008'
	OR convert(varchar, Registry.LastModified, 101) = '11/05/2007'
GO

 /* Test-Correct DOB anomalies CODA 
SELECT ID, DateAdd(yyyy,-100, DOB) AS NewDOB, DOB AS 'OldDOB' FROM Registry WHERE DatePart(yyyy, DOB) > '2009' 
*/
UPDATE Registry SET DOB = DateAdd(yyyy,-100, DOB)
WHERE DatePart(yyyy, DOB) > '2009' 
GO

/* Correct orphaned sub categories */ 
UPDATE EventRegistry SET EventCategoryID = 18
--SELECT * FROM EventRegistry 
WHERE RegistryID IN 
(
26355,
25915,
25944,
25945,
25946,
26744,
26048,
26052,
26079,
26315,
26354,
26287,
27020,
27021,
27022,
27135,
27136,
27134,
26972,
27137,
27139
)
AND EventCategoryID = 0
GO


ALTER TABLE Registry ENABLE TRIGGER Update_REGISTRY
GO
------Update End------------------
