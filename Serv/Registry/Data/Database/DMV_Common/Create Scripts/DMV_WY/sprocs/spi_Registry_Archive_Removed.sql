 SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_Registry_Archive_Removed    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Registry_Archive_Removed]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Registry_Archive_Removed]
GO




CREATE PROCEDURE spi_Registry_Archive_Removed
	@RegistryID	INT = NULL,
	@ArchiveReason 	INT = 5
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/ 
 
 begin transaction ARCHIVE
 	-- REGISTRYARCHIVE


	insert REGISTRYARCHIVE
	select [ID], [SSN], [DOB], [FirstName], [MiddleName], [LastName], [Suffix], [Gender], [Race], [EyeColor], [Phone], [Comment], [DMVID], [License], [DMVDonor], [Donor], [DonorConfirmed], [SourceCode], [OnlineRegDate], [SignatureDate], [MailerDate], [DeleteFlag], [DeleteDate], [DeletedByID], [UserID], [LastModified], [CreateDate], [DeceasedDate], @ArchiveReason 
	from REGISTRY
	where REGISTRY.ID = @RegistryID

	-- REGISTRYARCHIVEADDR
	insert REGISTRYARCHIVEADDR
	select REGISTRY.[ID], [RegistryID], [AddrTypeID], [Addr1], [Addr2], [City], [State], [Zip], REGISTRY.[UserID], REGISTRY.[LastModified], REGISTRY.[CreateDate]
	from REGISTRY, REGISTRYADDR
	where REGISTRY.ID = REGISTRYADDR.REGISTRYID
	and   REGISTRY.ID = @RegistryID

	/*
	-- REGISTRYARCHIVEORGAN
	insert REGISTRYARCHIVEORGAN
	select REGISTRYORGAN.* from REGISTRY, REGISTRYORGAN
	where REGISTRY.ID = REGISTRYORGAN.REGISTRYID
	and   REGISTRY.ID = @RegistryID

	-- REGISTRYARCHIVEGIFT
	insert REGISTRYARCHIVEGIFT
	select REGISTRYGIFT.* from REGISTRY, REGISTRYGIFT
	where REGISTRY.ID = REGISTRYGIFT.REGISTRYID
	and   REGISTRY.ID = @RegistryID

	-- REGISTRYGIFT
	delete from REGISTRYGIFT
	from REGISTRY, REGISTRYGIFT
	where REGISTRY.ID = REGISTRYGIFT.REGISTRYID
	and   REGISTRY.ID = @RegistryID

	-- REGISTRYORGAN
	delete from REGISTRYORGAN
	from REGISTRY, REGISTRYORGAN
	where REGISTRY.ID = REGISTRYORGAN.REGISTRYID
	and   REGISTRY.ID = @RegistryID
	*/
	-- REGISTRYADDR
	delete from REGISTRYADDR
	from REGISTRY, REGISTRYADDR
	where REGISTRY.ID = REGISTRYADDR.REGISTRYID
	and   REGISTRY.ID = @RegistryID
	
	-- REGISTRY
	delete from REGISTRY
	from REGISTRY
	where REGISTRY.ID = @RegistryID
 commit transaction ARCHIVE
CHECKPOINT
-- SELECT * FROM REGISTRYARCHIVETYPE













GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

