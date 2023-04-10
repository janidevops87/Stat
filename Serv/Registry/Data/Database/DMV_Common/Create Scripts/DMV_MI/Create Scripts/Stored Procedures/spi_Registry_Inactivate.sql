
CREATE PROCEDURE spi_Registry_Inactivate
 @RegistryID INT = NULL

AS

/*
  Moves active Registry records into RegistryArchive and RegistryArchiveAddr tables when set as Inactive.
  Based on spi_Registry_Archive_Removed
  Created 3/7/05 by Scott Plummer for Michigan registry upgrades.

*/

DECLARE @ArchiveReason INT
SET @ArchiveReason = 6  -- (Inactivated)
 
BEGIN TRANSACTION INACTIVATE
 -- Update Donor to 'N'
	UPDATE Registry SET Donor = 0 WHERE Registry.Id = @RegistryID;
 -- Insertions
  	-- RegistryArchive
	INSERT INTO RegistryArchive
	SELECT Registry.*, @ArchiveReason 
 	FROM Registry
	WHERE Registry.ID = @RegistryID;

 	-- RegistryArchiveAddr
	INSERT INTO RegistryArchiveAddr
 	SELECT RegistryADDR.* 
	FROM Registry, RegistryADDR
 	WHERE Registry.ID = RegistryADDR.RegistryID
 	AND Registry.ID = @RegistryID;

 -- Deletions
 	-- RegistryADDR
 	DELETE FROM RegistryADDR
 	FROM Registry, RegistryADDR
 	WHERE Registry.ID = RegistryADDR.RegistryID
 	AND Registry.ID = @RegistryID;
 
	-- Registry
	DELETE FROM Registry
 	FROM Registry
	WHERE Registry.ID = @RegistryID;

COMMIT TRANSACTION INACTIVATE;
GO
