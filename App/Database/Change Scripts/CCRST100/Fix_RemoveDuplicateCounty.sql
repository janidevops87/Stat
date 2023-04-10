/*** Fix for RemoveDuplicateCounty Updates ***
* ccarroll 05/06/2011
* Description: This Script addressed the following:
*	1. Locates, reassignes and removes unused or duplicate County records
*		from both Organization and County tables
*	2. Create Backup tables (optional)
*
* Release date: 
*/
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

/* Create Table Backups
PRINT 'Creating Backup: _County_Backup_ST100'
	IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_County_Backup_ST100')
	BEGIN
		DROP TABLE _County_Backup_ST100
	END
	SELECT CountyId, CountyName, StateID, Verified, Inactive, Lastmodified, UpdatedFlag
	INTO _County_Backup_ST100
	FROM County
PRINT 'Creating Backup: _Organization_Backup_ST100'
	IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_Organization_Backup_ST100')
	BEGIN
		DROP TABLE _Organization_Backup_ST100
	END
	SELECT OrganizationId, CountyID, StateID
	INTO _Organization_Backup_ST100
	FROM Organization
*/

/****** Begin Update ******/
/* Step 1 Identify Duplicates and make table of Counties and States */
DECLARE @CountyDuplicates TABLE
(
      Id Int IDENTITY(1, 1) NOT NULL,
      CountyName nvarchar(50) Null,
      Statename nvarchar(50) NULL
)

/*Step 2 Add Items to temp Table  ******/
INSERT INTO @CountyDuplicates (CountyName, StateName)
SELECT 
		CountyName,
		State.StateName
FROM County
JOIN State ON State.StateID = County.StateID
GROUP BY CountyName, Statename 
HAVING Count(CountyName) > 1
ORDER BY 1 DESC
--SELECT * FROM @CountyDuplicates
/******END Add Items ******/

DECLARE @CountyName NVarchar(50)
DECLARE @StateName NVarchar(50)
DECLARE @CountyId int
DECLARE @CurrentItemID int
DECLARE @UPDATE NVarchar(50)

SET  @UPDATE = 'UpdateCountyDuplicates'


WHILE (SELECT COUNT(*) FROM @CountyDuplicates) > 0
      BEGIN
		  SET @CurrentItemID = (SELECT MIN(Id) FROM @CountyDuplicates)

		  SELECT	@CountyName = t.CountyName,
					@StateName = t.StateName
		  FROM (SELECT CountyName, StateName FROM @CountyDuplicates WHERE Id = @CurrentItemID)t


			SET @CountyId = (SELECT Min(CountyID) 
			FROM County
			JOIN State ON State.StateID = County.StateID
			WHERE StateName Like @StateName AND CountyName Like @CountyName)

	BEGIN TRANSACTION @UPDATE
			/* Step 3 Update the organizations with the new County IDs */
			--SELECT 'UPDATE', org.CountyID AS OldCountyID, @CountyID AS NewCountyID, OrganizationName, CountyName, StateName
			UPDATE Organization SET Organization.CountyID = @CountyID
			FROM Organization org
			JOIN State ON State.StateID = org.StateID
			JOIN County ON org.CountyID = County.CountyID
			WHERE StateName Like @StateName AND CountyName Like @CountyName AND org.CountyID <> @CountyID


			/* Step 4 Remove the duplicates from the County table */
			--SELECT 'DELETE', cty.CountyID, CountyName, StateName
			DELETE FROM County
			FROM County cty
			JOIN State ON State.StateID = cty.StateID
			WHERE StateName Like @StateName AND CountyName Like @CountyName AND cty.CountyID <> @CountyID


			PRINT	'Duplicate_Id:' + 
					Cast(@CurrentItemID AS Varchar) + 
					' - Re-assigned: ' + 
					Cast(@CountyName AS Varchar) + ', ' + 
					Cast(@StateName AS Varchar) + ' To CountyId:' + 
					Cast(@CountyId AS Varchar)
	
	COMMIT TRANSACTION @UPDATE

		  DELETE @CountyDuplicates WHERE Id = @CurrentItemID

		END
PRINT 'Finished'
GO
/****** End Update ******/

