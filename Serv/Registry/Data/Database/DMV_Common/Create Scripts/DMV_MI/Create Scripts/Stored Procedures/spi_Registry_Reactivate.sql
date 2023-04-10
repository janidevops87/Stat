
CREATE PROCEDURE spi_Registry_Reactivate
 @RegistryID INT = NULL

AS

/*
  Moves inactive Registry records from RegistryArchive and RegistryArchiveAddr tables when set as active.
  Based on spi_Registry_Inactivate
  Created 3/7/05 by Scott Plummer for Michigan registry upgrades.

*/
 
BEGIN TRANSACTION REACTIVATE
 -- Insertions
	SET IDENTITY_INSERT Registry ON;

  	-- RegistryArchive
	INSERT INTO Registry ( ID, SSN, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Race, EyeColor, Phone, Comment, DMVID, License, 
		DMVDonor, Donor, DonorConfirmed, SourceCode, OnlineRegDate, SignatureDate, MailerDate, DeleteFlag, 
		DeleteDate, DeletedByID, UserID, LastModified, CreateDate, DeceasedDate, InfoSource, InfoSourceDesc, WitnessType1, WitnessType2, 
		Religion, Newsletter, Active)
	SELECT ID, SSN, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Race, EyeColor, Phone, Comment, DMVID, License, 
	DMVDonor, 1 AS Donor, DonorConfirmed, SourceCode, OnlineRegDate, SignatureDate, MailerDate, DeleteFlag, 
	DeleteDate, DeletedByID, UserID, GetDate() AS LastModified, CreateDate, DeceasedDate, InfoSource, InfoSourceDesc, WitnessType1, WitnessType2, 
	Religion, Newsletter, Active
 	FROM RegistryArchive
	WHERE RegistryArchive.ID = @RegistryID;

	SET IDENTITY_INSERT Registry OFF;

 	-- RegistryArchiveAddr
	INSERT INTO RegistryAddr (RegistryId, AddrTypeID, Addr1, Addr2, City, State, Zip, UserID, LastModified, CreateDate )
 	SELECT RegistryArchiveID AS [ID], AddrTypeID, Addr1, Addr2, City, State, Zip, UserID, GetDate() AS LastModified, CreateDate 
	FROM RegistryArchiveAddr
 	WHERE RegistryArchiveAddr.RegistryArchiveID = @RegistryID;

 -- Deletions
 	-- RegistryADDR
 	DELETE FROM RegistryArchiveAddr
 	WHERE RegistryArchiveAddr.RegistryArchiveId = @RegistryID;
 
	-- Registry
	DELETE FROM RegistryArchive
 	WHERE RegistryArchive.ID = @RegistryID;

COMMIT TRANSACTION REACTIVATE;
GO
